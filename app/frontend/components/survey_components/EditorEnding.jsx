import React from 'react';
import TextInput from './TextInput';
import OpenQuestion from './OpenQuestion';

function EditorIntroduction({
  ending,
  isOpen,
  handleEndingTextInputChange,
  handleEndingBooleanQuestionChange,
}) {
  return (
    <div className={`p-8 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-primary-500 mb-3">Thank you screen</h1>
      <p className="mb-3 text-sm">
        The last thing
      </p>

      <div className="mb-12">
        <TextInput
          label="headline"
          dataLabel="headline"
          value={ending.headline}
          onValueChange={handleEndingTextInputChange}
        />
        <TextInput
          label="subheadline"
          dataLabel="subheadline"
          value={ending.subheadline}
          onValueChange={handleEndingTextInputChange}
        />

        <OpenQuestion
          openQuestion={ending.include_sharing}
          label="Include sharing options"
          id="ending-question"
          onValueChange={handleEndingBooleanQuestionChange}
        />
      </div>

    </div>
  );
}

export default EditorIntroduction;
