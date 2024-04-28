import React, { useState } from 'react';
import TextareaAutosize from 'react-autosize-textarea';

function Segment({
  question,
  index,
  label,
  indexNumber,
  onValueChange,
  onValueDelete,
  showDeleteButton,
  showError,
}) {
  const [touched, setTouched] = useState(false);

  const handleBlur = () => {
    setTouched(true);
  };

  const handleChange = (e) => {
    onValueChange(e.target.dataset.index, e.target.value);
  };

  const handleDelete = (e) => {
    e.preventDefault();
    onValueDelete(e.target.dataset.index);
  };

  return (
    <div className="overflow-hidden py-2 bg-gray-300 rounded mb-5">
      <div className="px-6 pt-3 flex justify-between">
        <span className="font-bold">{`${label} ${parseInt(indexNumber, 10) + 1}`}</span>
        {(showDeleteButton)
        && (
        <button
          type="button"
          onClick={handleDelete}
          className="text-sm text-gray-600 hover:text-gray-900"
          data-index={index}
        >
          Delete
        </button>
        )}
      </div>

      <div className="px-6 py-4 flex">
        <div className="w-full">
          <TextareaAutosize
            style={{
              minHeight: '2.625rem',
              boxSizing: 'border-box',
              fontSize: '1rem',
              padding: '.5rem 1rem .5rem 1rem',
            }}
            id={`segment_questions_${index}`}
            value={question}
            className={`text-input ${(showError && touched && question === '') ? 'error' : ''}`}
            data-index={index}
            onChange={handleChange}
            onBlur={handleBlur}
            placeholder="Start typing..."
            required="required"
          />
          {(showError && touched && question === '') && (
            <span className="text-sm text-red-500 block -mt-1">
              {label}
              {' '}
              cannot be blank. Please fill in or delete it.
            </span>
          )}
        </div>
      </div>
    </div>
  );
}

export default Segment;
