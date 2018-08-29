package com.sudoku.model {

public class SudokuItemData
{
    private var _id:uint;

    private var _value:uint;

    private var _availableValues:String;

    private var _relatedColumnsIndices:Vector.<uint>;

    private var _relatedRowIndices:Vector.<uint>;

    private var _relatedBlockIndices:Vector.<uint>;

    public function SudokuItemData(id:uint)
    {
        this._id = id;

        init();
    }

    private function init():void
    {
        var columnIndex:uint = _id%9;
        var rowIndex:uint = Math.floor(_id/9);

        _relatedColumnsIndices = getAllItemsInColumn(columnIndex);
        _relatedRowIndices = getAllItemsInRow(rowIndex);
        _relatedBlockIndices = getAllItemsInBlock(Math.floor(columnIndex/3), Math.floor(rowIndex/3));
    }

    public function get id():uint
    {
        return _id;
    }

    [Bindable]
    public function get value():uint
    {
        return _value;
    }
    public function set value(value:uint):void
    {
        _value = value;
    }

    [Bindable]
    public function get availableValues():String
    {
        return _availableValues;
    }
    public function set availableValues(value:String):void
    {
        _availableValues = value;
    }

    public function get relatedColumnsIndices():Vector.<uint>
    {
        return _relatedColumnsIndices;
    }

    public function get relatedRowIndices():Vector.<uint>
    {
        return _relatedRowIndices;
    }

    public function get relatedBlockIndices():Vector.<uint>
    {
        return _relatedBlockIndices;
    }

    private function getAllItemsInRow(index:uint):Vector.<uint>
    {
        var indices:Vector.<uint> = new <uint>[];

        for(var i:uint = 0; i < 9; i++)
        {
            indices.push(index*9 + i);
        }

        return indices;
    }

    private function getAllItemsInColumn(index:uint):Vector.<uint>
    {
        var indices:Vector.<uint> = new <uint>[];

        for(var i:uint = 0; i < 9; i++)
        {
            indices.push(i*9 + index);
        }

        return indices;
    }

    private function getAllItemsInBlock(columnIndex:uint, rowIndex:uint):Vector.<uint>
    {
        var indices:Vector.<uint> = new <uint>[];

        for(var i:uint = 0; i < 9; i++)
        {
            indices.push(((rowIndex*3 + Math.floor(i/3)) * 9) + (columnIndex*3 + i%3));
        }

        return indices;
    }
}
}
