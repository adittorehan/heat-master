import ChevronRight from 'images/icons/chevron-right.svg'; // eslint-disable-line import/no-unresolved
import React, { useEffect, useState } from 'react';
import Segment from './Segment';
import OpenQuestion from './OpenQuestion';
import ModalExample from './ModalExample';

function EditorMarketSegment({
  marketSegment,
  isOpen,
  handleMarketSegmentQuestionsChange,
  handleMarketOpenQuestionChange,
  deleteMarketSegment,
  addMarketSegment,
}) {
  const [showDeleteButton, setShowDeleteButton] = useState(true);
  const [showAddAnotherButton, setShowAddAnotherButton] = useState(true);
  const [modalIsOpen, setModalIsOpen] = useState(false);

  useEffect(() => {
    const questionCount = Object.keys(marketSegment.segment_questions).length;
    if (questionCount === 0) {
      addMarketSegment();
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
  }, [marketSegment, addMarketSegment]);

  const openModal = () => setModalIsOpen(true);
  const closeModal = () => setModalIsOpen(false);

  const addAnotherButton = showAddAnotherButton ? (
    <button
      name="button"
      type="button"
      onClick={addMarketSegment}
      className="button-outline"
    >
      Add another
    </button>
  ) : (
    <p className="text-center mb-5 text-sm text-gray-500">You reached the limit of 5 segments</p>
  );

  const modalContentBlocks = [
    'Avoid being too general. You want those taking the survey to feel like they "belong" to the group describe.',
 
 	'A market segment might be described as "people who share a common need and speak a similar language."’
 	+ ‘“Speak a similar language” means that they would refer to each other for solutions that address’ 
 	+ ‘ their common need.',
 
    'One way to think about your segment is as a community -- a group of people who come together‘
    +’ because of some shared need or interest. Demographics might be involved,
    + ‘but aren’t the driving characteristics.',
    
    'Good market segments separate users from buyers and purchasing influencers. Each may represent '
    + ' a different segment, because their needs may be different.',
    
    'Try to stay away from industry verticals (like “financial services” or “healthcare”) and demographics like ‘
    + ‘“My market segment are millennials” or all iPhone users.',
  ];

  const exampleContentBlocks = [
    '"Couples in their early / mid-twenties who are about to become first-time parents, '
    + 'and are the first ones in their social circle to do so."',
    '"Young, male hipsters who like to dress sharp, but hate to shop.”',
    ‘Urban professionals who bike to work.’,
    ‘IT managers of Fortune 500 companies facing network security issues.’,
    ‘Fine dining restaurant owners who are also the head chef.’,
    'Enterprise executives who are “change agents”, trying to develop a more entrepreneurial mindset.',
  ];

  return (
    <div className={`p-8 xl:px-16 ${isOpen ? 'block' : 'hidden'}`}>
      <h1 className="text-teal-600 mb-3">Market segment</h1>
      <p className="mb-5 text-sm">
        Who is your target market? Define your *ideal* customers based on a shared need or purpose.
        It can also include demographics, but only as required to define a group of
        like-minded people. The description should define &quot;real&quot; human beings you could
        go out into the world and find.
      </p>

      <div className="my-3" id="market-segment-container">
        {Object.keys(marketSegment.segment_questions).map((key, index) => (
          <Segment
            key={key}
            index={key}
            indexNumber={index}
            question={marketSegment.segment_questions[key]}
            label="Segment"
            onValueChange={handleMarketSegmentQuestionsChange}
            onValueDelete={deleteMarketSegment}
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
        Show examples of well defined customer segments
        <img
          src={ChevronRight}
          alt="Chevron right"
          className="fill-current text-teal-600 p-2"
          height="32"
          width="32"
        />
      </button>

      <OpenQuestion
        openQuestion={marketSegment.open_ended_question}
        label="Include open-ended question?"
        onValueChange={handleMarketOpenQuestionChange}
        id="market-segment-question"
      />

      <ModalExample
        isOpen={modalIsOpen}
        onRequestClose={closeModal}
        mainHeader="How to write a good customer segment (with examples)"
        firstTitle="What makes a good customer segment?"
        contentBlocks={modalContentBlocks}
        secondTitle="Examples"
        exampleBlocks={exampleContentBlocks}
      />
    </div>
  );
}

export default EditorMarketSegment;
