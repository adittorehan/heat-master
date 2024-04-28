import React from 'react';

function RangeInput({ question, segment, disabled }) {
  return (
    <div className="mb-5">
      <h2 className="text-xl my-3">{question}</h2>
      <div className="w-full">
        <input
          disabled={disabled}
          type="range"
          className="w-full"
          min={segment.min_scale}
          max={segment.max_scale}
          step="1"
          defaultValue="3"
          id="customRange2"
          list="ticks1"
        />
        <datalist id="ticks1">
          <option>1</option>
          <option>2</option>
          <option>3</option>
          <option>4</option>
          <option>5</option>
        </datalist>

        <div className="flex justify-between text-xs">
          <span>{segment.lowest_value_label}</span>
          <span>{segment.highest_value_label}</span>
        </div>
      </div>
    </div>
  );
}

export default RangeInput;
