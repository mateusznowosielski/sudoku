package com.sudoku.commands
{
import com.sudoku.model.SudokuItemData;

import mx.collections.ArrayList;

public class ResolveAvailableValuesCommand
{
    public function ResolveAvailableValuesCommand()
    {
    }

    public function execute(changedItem:SudokuItemData, allItems:ArrayList):void
    {
        var id:uint = changedItem.id;
        var index:uint;

        //trace(id + " :: " + changedItem.relatedColumnsIndices + " :: " + changedItem.relatedRowIndices + " :: " + changedItem.relatedBlockIndices);

        for(var i:uint = 0; i < allItems.length; i++)
        {
            allItems.getItemAt(i).availableValues = "123456789";
        }

        var relatedIndices:Vector.<uint> = changedItem.relatedColumnsIndices.concat(changedItem.relatedRowIndices).concat(changedItem.relatedBlockIndices);

        for each(index in relatedIndices)
        {
            var item:SudokuItemData = allItems.getItemAt(index) as SudokuItemData;

            removeUnavailableValues(item, item.relatedColumnsIndices, allItems);
            removeUnavailableValues(item, item.relatedRowIndices, allItems);
            removeUnavailableValues(item, item.relatedBlockIndices, allItems);
        }
    }

    private function removeUnavailableValues(changedItem:SudokuItemData, sameIndices:Vector.<uint>, allItems:ArrayList):void
    {
        var item:SudokuItemData;
        var i:uint;
        var used:Vector.<uint> = new <uint>[];
        var availableValuesArray:Array;

        for(i = 0; i < sameIndices.length; i++)
        {
            item = allItems.getItemAt(sameIndices[i]) as SudokuItemData;

            if(item.value > 0)
            {
                used.push(item.value);
            }
        }

        for(i = 0; i < sameIndices.length; i++)
        {
            item = allItems.getItemAt(sameIndices[i]) as SudokuItemData;
            availableValuesArray = item.availableValues.split("");

            for each(var idx:uint in used)
            {
                var valueIdx:int = availableValuesArray.indexOf(idx.toString());

                if(valueIdx > -1)
                {
                    availableValuesArray.splice(valueIdx, 1);
                }
            }

            item.availableValues = availableValuesArray.join("");
        }
    }
}
}
