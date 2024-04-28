import FacebookIcon from 'images/icons/facebook.svg'; // eslint-disable-line import/no-unresolved
import EmailIcon from 'images/icons/mail.svg'; // eslint-disable-line import/no-unresolved
import TwitterIcon from 'images/icons/twitter.svg'; // eslint-disable-line import/no-unresolved
import LinkedinIcon from 'images/icons/linkedin.svg'; // eslint-disable-line import/no-unresolved
import ClipboardIcon from 'images/icons/white-clipboard.svg'; // eslint-disable-line import/no-unresolved

import React from 'react';
import RangeInput from './RangeInput';
import PreviewTextAreaInput from './PreviewTextAreaInput';
import PreviewTextInput from './PreviewTextInput';
import CheckBoxInput from './CheckBoxInput';

function EditorPreview({
  introduction,
  marketSegment,
  problemStatement,
  solutionStatement,
  feedback,
  ending,
  introductionIsOpen,
  marketSegmentIsOpen,
  problemStatementIsOpen,
  solutionStatementIsOpen,
  feedbackIsOpen,
  endingIsOpen,
  shareLink,
  introductionImage,
}) {
  const isEmpty = (obj) => Object.getOwnPropertyNames(obj).length === 0;

  const marketSegments = !isEmpty(marketSegment.segment_questions) ? (
    <div className="mb-5">
      {Object.keys(marketSegment.segment_questions).map((key) => (
        <RangeInput
          key={key}
          question={marketSegment.segment_questions[key]}
          segment={marketSegment}
        />
      ))}
    </div>
  ) : (
    <div className="w-full border-2 border-dashed text-center">
      <p className="p-3 text-sm text-gray-500">Market segments will show up here</p>
    </div>
  );

  const problemSegments = !isEmpty(problemStatement.problem_segments) ? (
    <div className="mb-5">
      {Object.keys(problemStatement.problem_segments).map((key) => (
        <RangeInput
          key={key}
          question={problemStatement.problem_segments[key]}
          segment={problemStatement}
        />
      ))}
    </div>
  ) : (
    <div className="w-full border-2 border-dashed text-center">
      <p className="p-3 text-sm text-gray-500">Problem Statements will show up here</p>
    </div>
  );

  const solutionSegments = !isEmpty(solutionStatement.solution_segments) ? (
    <div className="mb-5">
      {Object.keys(solutionStatement.solution_segments).map((key) => (
        <RangeInput
          key={key}
          question={solutionStatement.solution_segments[key]}
          segment={solutionStatement}
        />
      ))}
    </div>
  ) : (
    <div className="w-full border-2 border-dashed text-center">
      <p className="p-3 text-sm text-gray-500">Solution statements will show up here</p>
    </div>
  );

  const feedbackOptionsList = feedback.ask_for_testing_options.split('\n');
  const feedbackOptions = feedbackOptionsList.length ? (
    feedbackOptionsList.map((option, i) => (
      // TODO: Fix this behavior to Object
      // eslint-disable-next-line react/no-array-index-key
      <CheckBoxInput key={i} id={i} option={option.trim()} />
    ))
  ) : (
    <div className="w-full border-2 border-dashed text-center">
      <p className="p-3 text-sm text-gray-500">Options will show up here</p>
    </div>
  );

  const isFeedbackEmpty = !(
    feedback.ask_for_testing
    || feedback.ask_for_email
    || feedback.open_ended_question
  );

  return (
    <div className="w-1/2 border-l border-gray-400">
      <div className="width-full bg-gray-300 text-center">
        <h3 className="py-4 font-bold">This is a preview of your survey</h3>
      </div>

      <div
        className={`p-10 xl:px-16 text-center ${
          introductionIsOpen ? 'block' : 'hidden'
        }`}
      >
        <div className="mb-10 mt-10">
          <div className="flex justify-center content-center mb-3">
            <img src={introductionImage} alt="Logo preview" className="w-20" />
          </div>
          <h1 className="text-2xl font-bold mb-3">{introduction.headline}</h1>
          <p>{introduction.subheadline}</p>
        </div>
      </div>

      <div className={`p-8 xl:px-16 ${marketSegmentIsOpen ? 'block' : 'hidden'}`}>
        <div className="mb-10">
          <h1 className="text-2xl font-bold mb-3">{marketSegment.headline}</h1>
          <p>{marketSegment.subheadline}</p>
        </div>

        {marketSegments}

        {marketSegment.open_ended_question && (
          <PreviewTextAreaInput label="How would you describe the market segment you belong to?" />
        )}
      </div>

      <div className={`p-8 xl:px-16 ${problemStatementIsOpen ? 'block' : 'hidden'}`}>
        <div className="mb-10">
          <h1 className="text-2xl font-bold mb-3">{problemStatement.headline}</h1>
          <p>{problemStatement.subheadline}</p>
        </div>

        {problemSegments}

        {problemStatement.open_ended_question && (
          <PreviewTextAreaInput label="In what ways have you tried addressing the problems/needs you experience?" />
        )}
      </div>

      <div className={`p-8 xl:px-16 ${solutionStatementIsOpen ? 'block' : 'hidden'}`}>
        <div className="mb-10">
          <h1 className="text-2xl font-bold mb-3">{solutionStatement.headline}</h1>
          <p>{solutionStatement.subheadline}</p>
        </div>

        {solutionSegments}

        {solutionStatement.open_ended_question && (
          <PreviewTextAreaInput label="Have you tried any of the above solutions? If so, what happened?" />
        )}
      </div>

      {isFeedbackEmpty ? (
        <div className={`p-8 xl:px-16 bg-gray-300 h-full ${feedbackIsOpen ? 'block' : 'hidden'}`}>
          <div className="mb-10">
            <p>
              This page will not be shown in the actual survey,
              because you did not choose any options
            </p>
          </div>
        </div>
      ) : (
        <div className={`p-8 xl:px-16 ${feedbackIsOpen ? 'block' : 'hidden'}`}>
          <div className="mb-10">
            <h1 className="text-2xl font-bold mb-3">{feedback.headline}</h1>
            <p>{feedback.subheadline}</p>
          </div>

          {feedback.ask_for_testing && (
            <div className="mb-10">
              <h3 className="mb-3">{feedback.ask_for_testing_label}</h3>
              {feedbackOptions}
            </div>
          )}

          {feedback.ask_for_email && (
            <PreviewTextInput label={feedback.ask_for_email_label} type="email" />
          )}

          {feedback.open_ended_question && (
            <PreviewTextAreaInput label="Anything else you'd like to tell us?" />
          )}
        </div>
      )}

      <div className={`p-10 xl:px-16 text-center ${endingIsOpen ? 'block' : 'hidden'}`}>
        <div className="mb-20 mt-10">
          <h1 className="text-2xl font-bold mb-3">{ending.headline}</h1>
          <p>{ending.subheadline}</p>
        </div>

        {ending.include_sharing && (
          <div className="mb-10 text-center">
            <h3 className="text-xl">
              Do you know someone else who should take this survey?
              <br />
              Please share this URL.
            </h3>
            <div className="my-10 mx-auto w-1/2 text-center">
              <div className="border rounded pl-2 flex" data-controller="clipboard">
                <input
                  type="text"
                  data-target="clipboard.source"
                  className="w-full focus:outline-none"
                  defaultValue={shareLink}
                  readOnly
                />
                <button
                  type="button"
                  className="bg-black border border-black ml-2 px-1 py-1 rounded-r focus:outline-none"
                  data-action="clipboard#copy click@window->clipboard#hide"
                >
                  <img
                    src={ClipboardIcon}
                    alt="Copy to clipboard"
                    height="24"
                    width="24"
                  />
                </button>
                <span
                  className="hidden text-sm"
                  style={{
                    position: 'relative',
                    top: '45px',
                    left: '10px',
                    marginLeft: '-48px',
                  }}
                  data-target="clipboard.tooltip"
                >
                  Copied!
                </span>
              </div>
            </div>
            <div className="mt-5">
              <button type="button" className="focus:outline-none">
                <img
                  src={FacebookIcon}
                  alt="List icon"
                  className="inline p-2 mx-2"
                  height="50"
                  width="50"
                />
              </button>

              <button type="button" className="focus:outline-none">
                <img
                  src={EmailIcon}
                  alt="List icon"
                  className="inline p-2 mx-2"
                  height="50"
                  width="50"
                />
              </button>

              <button type="button" className="focus:outline-none">
                <img
                  src={TwitterIcon}
                  alt="List icon"
                  className="inline p-2 mx-2"
                  height="50"
                  width="50"
                />
              </button>

              <button type="button" className="focus:outline-none">
                <img
                  src={LinkedinIcon}
                  alt="List icon"
                  className="inline p-2 mx-2"
                  height="50"
                  width="50"
                />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default EditorPreview;
