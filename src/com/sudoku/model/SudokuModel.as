package com.sudoku.model {
import com.sudoku.commands.CreateSudokuItemsCommand;
import com.sudoku.commands.ResolveAvailableValuesCommand;

import flash.events.EventDispatcher;

import mx.collections.ArrayList;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.PropertyChangeEvent;

public class SudokuModel
{
    private var _sudokuItems:ArrayList;

    public function SudokuModel()
    {
    }

    [Bindable]
    public function get sudokuItems():ArrayList
    {
        var createSudokuItemsCommand:CreateSudokuItemsCommand = new CreateSudokuItemsCommand();
        _sudokuItems = createSudokuItemsCommand.execute();

        _sudokuItems.addEventListener(CollectionEvent.COLLECTION_CHANGE, _sudokuItems_collectionChangeHandler);

        return _sudokuItems;
    }

    private function _sudokuItems_collectionChangeHandler(event:CollectionEvent):void
    {
        if(event.kind == CollectionEventKind.UPDATE)
        {
            var propertyChangeEvent:PropertyChangeEvent = event.items[0] as PropertyChangeEvent;

            if(propertyChangeEvent.property != "value")
            {
                return;
            }

            var item:SudokuItemData = propertyChangeEvent.target as SudokuItemData;

            var resolveAvailableValuesCommand:ResolveAvailableValuesCommand = new ResolveAvailableValuesCommand();

            resolveAvailableValuesCommand.execute(item, event.target as ArrayList);
        }
    }
}
}
