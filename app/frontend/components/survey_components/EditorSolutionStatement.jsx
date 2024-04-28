import ChevronRight from 'images/icons/chevron-right.svg'; // eslint-disable-line import/no-unresolved
import React, { useEffect, useState } from 'react';
import Segment from './Segment';
import OpenQuestion from './OpenQuestion';
import ModalExample from './ModalExample';

function EditorSolutionStatement({
  solutionStatement,
  addSolutionStatement,
  deleteSolutionStatement,
  handleSolutionSegmentQuestionsChange,
  handleSolutionOpenQuestionChange,
  isOpen,
}) {
  const [showDeleteButton, setShowDeleteButton] = useState(true);
  const [showAddAnotherButton, setShowAddAnotherButton] = useState(true);
  const [modalIsOpen, setModalIsOpen] = useState(false);

  useEffect(() => {
    const questionCount = Object.keys(solutionStatement.solution_segments).length;
    if (questionCount === 0) {
      addSolutionStatement();
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
  }, [solutionStatement, addSolutionStatement]);

  const openModal = () => setModalIsOpen(true);
  const closeModal = () => setModalIsOpen(false);

  const addAnotherButton = showAddAnotherButton ? (
    <button
      name="button"
      type="button"
      onClick={addSolutionStatement}
      className="button-outline"
    >
      Add another
    </button>
  ) : (
    <p className="text-center mb-5 text-sm text-gray-500">You reached the limit of 5 solution statements</p>
  );

  const modalContentBlocks = [
    'Solution statements should be a balance between:\n'
    + '1) Specific to indicate they will address the need of the user or customer, and\n'
    + '2) Not overly technical or in the weeds.',
    'We\'re not writing a specification document, but rather trying to ascertain whether we\'re going down the '
    + 'right path in the perception of the customer. Remember, they don\'t actually know what\'s possible or what\'s '
    + 'best, but they  might understand the limitations of a particular approach.',
    'It\'s less important to describe, for instance, the technology behind offering "shaving razors as a service", '
    + 'than to know whether a subscription fits with the particular lifestyle of a specific market segment. '
    + '("I\'m a road warrior, sales-person. That makes no sense for me.")',
    'You should offer 3-5 descriptions, starting more general, then getting narrower to specific functionality.',
  ];

  const exampleContentBlocks = [
    '1. "Professional slacks that double as "bike to work" pants."',
    '2. "Pants have reflective cuffs and a back pocket, reflective flag which '
    + 'improves the safety of your ride, and are tucked in when at the office"',
    '3. "Pants wick away moisture and are quick-drying."\n',
    '1. "App that enables distributed teams to communicate more effectively than email or messaging."',
    '2. "App is fast, clear user experience design, and has flexible user/group/permissions administration."',
    '3. "App has great archive and search, syncs across-devices, and simple file sharing."',
  ];

  return (
    <div className={`p-8 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-primary-500 mb-3">Solution statements</h1>
      <p className="mb-5 text-sm">
        Describe the high-level ways you are considering to address the problems/needs
        of your market segments.
      </p>

      <div className="my-3" id="solution-segment-container">
        {Object.keys(solutionStatement.solution_segments).map((key, index) => (
          <Segment
            key={key}
            index={key}
            indexNumber={index}
            question={solutionStatement.solution_segments[key]}
            label="Solution Statement"
            sublabel="Statement"
            onValueChange={handleSolutionSegmentQuestionsChange}
            onValueDelete={deleteSolutionStatement}
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
        Show examples of well defined solution segments
        <img
          src={ChevronRight}
          alt="Chevron right"
          className="fill-current text-teal-600 p-2"
          height="32"
          width="32"
        />
      </button>

      <OpenQuestion
        openQuestion={solutionStatement.open_ended_question}
        label="Include open-ended question?"
        onValueChange={handleSolutionOpenQuestionChange}
        id="solution-statement-question"
      />

      <ModalExample
        isOpen={modalIsOpen}
        onRequestClose={closeModal}
        mainHeader="How to write a good solution statements (with examples)"
        firstTitle="What makes a good solution statement?"
        contentBlocks={modalContentBlocks}
        secondTitle="Example solution statements:"
        exampleBlocks={exampleContentBlocks}
      />
    </div>
  );
}

export default EditorSolutionStatement;
