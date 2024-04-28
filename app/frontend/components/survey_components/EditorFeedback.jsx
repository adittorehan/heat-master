import React from 'react';
import TextInput from './TextInput';
import OpenQuestion from './OpenQuestion';

function EditorFeedback({
  feedback,
  isOpen,
  handleFeedbackTextInputChange,
  handleFeedbackTestingChange,
  handleFeedbackEmailChange,
  handleFeedbackOpenQuestionChange,
}) {
  return (
    <div className={`p-8 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-primary-500 mb-3">Call to action</h1>
      <p className="mb-3 text-sm">
        You can measure potential customers level of interest based upon their willingness
        to further engage. So why not ask!
      </p>

      <div className="mb-12">
        <TextInput
          label="Page title"
          dataLabel="headline"
          value={feedback.headline}
          onValueChange={handleFeedbackTextInputChange}
        />
        <TextInput
          label="Page description"
          dataLabel="subheadline"
          value={feedback.subheadline}
          onValueChange={handleFeedbackTextInputChange}
        />
      </div>

      <div className="mb-12">
        <OpenQuestion
          openQuestion={feedback.ask_for_testing}
          label="Include Call to action?"
          id="feedback-testing-question"
          onValueChange={handleFeedbackTestingChange}
        />

        {feedback.ask_for_testing && (
          <div>
            <TextInput
              label="Question"
              dataLabel="ask_for_testing_label"
              value={feedback.ask_for_testing_label}
              onValueChange={handleFeedbackTextInputChange}
            />

            <TextInput
              label="Check box options (5 max)"
              dataLabel="ask_for_testing_options"
              value={feedback.ask_for_testing_options}
              onValueChange={handleFeedbackTextInputChange}
              rowLimit={5}
            />
          </div>
        )}
      </div>

      <div className="mb-12">
        <OpenQuestion
          openQuestion={feedback.ask_for_email}
          label="Ask for email address"
          onValueChange={handleFeedbackEmailChange}
          id="feedback-email-question"
        />

        {feedback.ask_for_email && (
          <TextInput
            label="Question"
            dataLabel="ask_for_email_label"
            value={feedback.ask_for_email_label}
            onValueChange={handleFeedbackTextInputChange}
          />
        )}
      </div>

      <OpenQuestion
        openQuestion={feedback.open_ended_question}
        label="Include open-ended question?"
        onValueChange={handleFeedbackOpenQuestionChange}
        id="feedback-question"
      />
    </div>
  );
}

export default EditorFeedback;
