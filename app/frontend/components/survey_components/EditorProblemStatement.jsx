import ChevronRight from 'images/icons/chevron-right.svg'; // eslint-disable-line import/no-unresolved
import React, { useEffect, useState } from 'react';
import Segment from './Segment';
import OpenQuestion from './OpenQuestion';
import ModalExample from './ModalExample';

function EditorProblemStatement({
  problemStatement,
  deleteProblemStatement,
  addProblemStatement,
  isOpen,
  handleProblemSegmentQuestionsChange,
  handleProblemOpenQuestionChange,
}) {
  const [showDeleteButton, setShowDeleteButton] = useState(true);
  const [showAddAnotherButton, setShowAddAnotherButton] = useState(true);
  const [modalIsOpen, setModalIsOpen] = useState(false);

  useEffect(() => {
    const questionCount = Object.keys(problemStatement.problem_segments).length;
    if (questionCount === 0) {
      addProblemStatement();
    }
    if (questionCount === 1) {
      setShowDeleteButton(false);
    } else {
      setShowDeleteButton(true);
    }
    if (questionCount < 5) {
      setShowAddAnotherButton(true);
    } else {
      setShowAddAnotherButton(false);
    }
  }, [problemStatement, addProblemStatement]);

  const openModal = () => setModalIsOpen(true);
  const closeModal = () => setModalIsOpen(false);

  const addAnotherButton = showAddAnotherButton ? (
    <button
      name="button"
      type="button"
      onClick={addProblemStatement}
      className="button-outline"
    >
      Add another
    </button>
  ) : (
    <p className="text-center mb-5 text-sm text-gray-500">You reached the limit of 5 problem statements</p>
  );

  const modalContentBlocks = [
    'A good problem statement describes the gap between the current state and the desired state. '
    + 'For the sake of this exercise, you want to put yourself in the place of the person facing '
    + 'the issue, and begin with “I”. (This is not a hard and fast rule, but may be useful.)\n',
    'Use your market segment definitions to think of the person for whom you’re describing their problem.\n',
    'Instead of “problem”, you might think of it terms of a need, desire, pain point, or even a passion.',
    'Do not include a solution in the problem statement!',
  ];

  const exampleContentBlocks = [
    'I have trouble finding good looking clothes, that fit well. And I hate to shop!',
    'I don’t know how to apply my newly learned leadership skills in my every day work.',
    'I’m struggling with buying diapers because they are expensive.',
    'I don’t have time to organize family photos so feel like I’m not documenting my children’s life growing up.',
    'I need to establish redundancy in my global supply chain.',
  ];

  return (
    <div className={`p-8 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-primary-500 mb-3">
        Problem statements
      </h1>
      <p className="mb-5">
        Describe the problem, need, desire or passion experienced by the market segments
        that your product or service seeks to address. What does your market segment
        hope or need to accomplish?
      </p>

      <div className="my-3" id="problem-segment-container">
        {Object.keys(problemStatement.problem_segments).map((key, index) => (
          <Segment
            key={key}
            index={key}
            indexNumber={index}
            question={problemStatement.problem_segments[key]}
            label="Problem Statement"
            sublabel="Statement"
            onValueChange={handleProblemSegmentQuestionsChange}
            onValueDelete={deleteProblemStatement}
            showDeleteButton={showDeleteButton}
            showError
          />
        ))}
      </div>

      {addAnotherButton}

      <button
        onClick={openModal}
        type="button"
        className="w-full bg-white flex items-center justify-between py-3 px-5 mt-4 rounded text-sm text-teal-400 font-bold border border-gray-300 shadow hover:shadow-md hover:border-gray-400"
      >
        Show examples of well defined problem statements
        <img
          src={ChevronRight}
          alt="Chevron right"
          className="fill-current text-teal-600 p-2"
          height="32"
          width="32"
        />
      </button>

      <OpenQuestion
        openQuestion={problemStatement.open_ended_question}
        label="Include open-ended question?"
        onValueChange={handleProblemOpenQuestionChange}
        id="problem-statement-question"
      />

      <ModalExample
        isOpen={modalIsOpen}
        onRequestClose={closeModal}
        mainHeader="How to write a good problem statements (with examples)"
        firstTitle="What makes a good problem or needs statement?"
        contentBlocks={modalContentBlocks}
        secondTitle="Examples:"
        exampleBlocks={exampleContentBlocks}
      />
    </div>
  );
}

export default EditorProblemStatement;
