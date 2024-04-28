import React from 'react';
import TextInput from './TextInput';
import ImageInput from './ImageInput';

function EditorIntroduction({
  introduction,
  isOpen,
  handleIntroductionTextInputChange,
  handleIntroductionImageInputChange,
}) {
  return (
    <div className={`px-8 pt-8 pb-2 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-primary-500 mb-3">Introduction to survey</h1>
      <p className="mb-3 text-sm">
        This is the first screen respondents see. Describe the title
        and purpose of the survey. Include instructions if desired
      </p>

      <div className="mb-12">
        <TextInput
          label="Survey title"
          dataLabel="headline"
          value={introduction.headline}
          onValueChange={handleIntroductionTextInputChange}
          required="required"
          showError
        />
        <TextInput
          label="Survey description"
          dataLabel="subheadline"
          value={introduction.subheadline}
          onValueChange={handleIntroductionTextInputChange}
          required="required"
          showError
        />
        <ImageInput
          label="image"
          id="introduction_image"
          onValueChange={handleIntroductionImageInputChange}
          class="cursor-pointer"
        />
      </div>
      <p className="mt-3 text-sm">
        Add customer, problem, solution assumptions below:
      </p>
    </div>
  );
}

export default EditorIntroduction;
