package com.sudoku.commands {
import com.sudoku.model.SudokuItemData;

import mx.collections.ArrayList;

public class CreateSudokuItemsCommand
{

    public function CreateSudokuItemsCommand()
    {
    }

    public function execute():ArrayList
    {
        var items:ArrayList = new ArrayList();

        for(var i:uint = 0; i < 81; i++)
        {
            var sid:SudokuItemData = new SudokuItemData(i);
            items.addItem(sid);
        }

        return items;
    }
}
}
