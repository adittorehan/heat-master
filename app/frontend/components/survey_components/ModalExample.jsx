import React from 'react';
import Modal from 'react-modal';
import ListIcon from 'images/icons/list.svg'; // eslint-disable-line import/no-unresolved

Modal.setAppElement('[data-react-class="SurveyEditor"]');

function ModalExample({
  isOpen,
  onRequestClose,
  mainHeader,
  firstTitle,
  contentBlocks,
  secondTitle,
  exampleBlocks,
}) {
  const contentBlockItems = contentBlocks.map((block, index) => <p key={index.toString()} className="pb-3">{block}</p>);
  const exampleBlockItems = exampleBlocks.map((block, index) => <p key={index.toString()} className="">{block}</p>);

  return (
    <Modal
      isOpen={isOpen}
      onRequestClose={onRequestClose}
      contentLabel="Modal how to"
      overlayClassName="bg-transparent-black-60 fixed inset-0 flex justify-center items-center"
      className="bg-white py-4 px-6 rounded max-w-3xl overflow-auto"
    >
      <main className="mb-4">
        <h1 className="font-semibold text-sm text-teal-400 mb-5">
          <img
            src={ListIcon}
            alt="List icon"
            className="inline rounded-full bg-teal-200 text-teal-600 mr-2 p-2"
            height="34"
            width="34"
          />
          {mainHeader}
        </h1>

        <h2 className="text-lg pb-3">{firstTitle}</h2>
        {contentBlockItems}

        <h2 className="text-lg pb-3">{secondTitle}</h2>
        {exampleBlockItems}

      </main>
      <button
        className="modal__btn bg-transparent w-full hover:bg-primary-500 text-primary-500
                         font-semibold hover:text-white py-2 px-4 border border-primary-500 rounded"
        type="button"
        onClick={onRequestClose}
        aria-label="Close this dialog window"
      >
        Close
      </button>
    </Modal>
  );
}

export default ModalExample;
