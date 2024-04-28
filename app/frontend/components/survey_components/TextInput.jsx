import React, { useState } from 'react';
import TextareaAutosize from 'react-autosize-textarea';

function TextInput({
  value,
  label,
  dataLabel,
  disabled,
  onValueChange,
  required,
  showError,
  rowLimit,
}) {
  const [touched, setTouched] = useState(false);
  const [rowError, setRowError] = useState(false);

  const handleBlur = () => {
    setTouched(true);
  };

  const handleChange = (e) => {
    if (rowLimit) {
      const currentRows = e.target.value.split('\n').length;
      if (currentRows > rowLimit) {
        setRowError(true);
        return;
      }
      setRowError(false);
    }
    onValueChange(dataLabel, e.target.value);
  };

  return (
    <div className="flex my-6">
      <div className="w-4/12">
        <label className="text-gray-500 text-sm" htmlFor={label}>
          {label.charAt(0).toUpperCase() + label.slice(1)}
        </label>
      </div>
      <div className="w-8/12">
        <TextareaAutosize
          style={{
            minHeight: '2.625rem',
            boxSizing: 'border-box',
            fontSize: '16px',
            padding: '.5rem 1rem .5rem 1rem',
          }}
          id={label}
          className={`text-input ${
            (showError && touched && value === '') || rowError ? 'error' : ''
          }`}
          value={value}
          disabled={disabled}
          onChange={handleChange}
          onBlur={handleBlur}
          placeholder="Start typing..."
          required={required}
        />
        {showError && touched && value === '' && (
          <span className="text-sm text-red-500 block -mt-1">cannot be blank</span>
        )}
        {rowLimit && rowError && value !== '' && (
          <span className="text-sm text-red-500 block -mt-1">{`cannot be more than ${rowLimit} calls to action`}</span>
        )}
      </div>
    </div>
  );
}

export default TextInput;
