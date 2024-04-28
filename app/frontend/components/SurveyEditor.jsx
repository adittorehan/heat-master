import React from 'react';
import ActionCable from 'actioncable';

// eslint-disable-next-line import/no-unresolved
import PlaceholderImage from 'images/icons/placeholder-image.png';
import EditorPreview from './survey_components/EditorPreview';
import EditorIntroduction from './survey_components/EditorIntroduction';
import EditorMarketSegment from './survey_components/EditorMarketSegment';
import EditorProblemStatement from './survey_components/EditorProblemStatement';
import EditorSolutionStatement from './survey_components/EditorSolutionStatement';
import EditorFeedback from './survey_components/EditorFeedback';
import EditorEnding from './survey_components/EditorEnding';

class SurveyEditor extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      introduction: props.introduction,
      marketSegment: props.market_segment,
      problemStatement: props.problem_statement,
      solutionStatement: props.solution_statement,
      feedback: props.feedback,
      ending: props.ending,
      introductionIsOpen: true,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: false,
      feedbackIsOpen: false,
      endingIsOpen: false,
      introductionImage: props.introduction_image ? props.introduction_image : PlaceholderImage,
    };
  }

  componentDidMount() {
    const cable = ActionCable.createConsumer();
    this.sub = cable.subscriptions.create('SurveysChannel');
  }

  sendData = () => {
    const {
      introduction,
      marketSegment,
      problemStatement,
      solutionStatement,
      feedback,
      ending,
    } = this.state;

    this.sub.send({
      id: marketSegment.survey_id,
      introduction,
      market_segment: marketSegment,
      problem_statement: problemStatement,
      solution_statement: solutionStatement,
      feedback,
      ending,
    });
  };

  showIntroduction = () => {
    this.setState({
      introductionIsOpen: true,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: false,
      feedbackIsOpen: false,
      endingIsOpen: false,
    });
  };

  showMarketSegment = () => {
    this.setState({
      introductionIsOpen: false,
      marketSegmentIsOpen: true,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: false,
      feedbackIsOpen: false,
      endingIsOpen: false,
    });
  };

  showProblemStatement = () => {
    this.setState({
      introductionIsOpen: false,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: true,
      solutionStatementIsOpen: false,
      feedbackIsOpen: false,
      endingIsOpen: false,
    });
  };

  showSolutionStatement = () => {
    this.setState({
      introductionIsOpen: false,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: true,
      feedbackIsOpen: false,
      endingIsOpen: false,
    });
  };

  showFeedback = () => {
    this.setState({
      introductionIsOpen: false,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: false,
      feedbackIsOpen: true,
      endingIsOpen: false,
    });
  };

  showEnding = () => {
    this.setState({
      introductionIsOpen: false,
      marketSegmentIsOpen: false,
      problemStatementIsOpen: false,
      solutionStatementIsOpen: false,
      feedbackIsOpen: false,
      endingIsOpen: true,
    });
  };


  handleIntroductionTextInputChange = (property, value) => {
    this.setState(
      (prevState) => ({
        introduction: { ...prevState.introduction, [property]: value },
      }),
      () => this.sendData(),
    );
  };

  handleIntroductionImageInputChange = (value) => {
    const reader = new FileReader();
    const file = value.target.files[0];

    reader.onload = (e) => {
      const url = e.target.result;
      this.setState({ introductionImage: url });
    };
    reader.readAsDataURL(file);

    const formData = new FormData();
    formData.append('image', file);

    // eslint-disable-next-line no-undef
    $.ajax({
      type: 'PATCH',
      // eslint-disable-next-line react/destructuring-assignment
      url: this.props.image_upload_link,
      processData: false,
      contentType: false,
      data: formData,
    });
  };

  handleMarketOpenQuestionChange = (value) => {
    this.setState(
      (prevState) => ({
        marketSegment: {
          ...prevState.marketSegment,
          open_ended_question: value,
        },
      }),
      () => this.sendData(),
    );
  };

  addMarketSegment = () => {
    const { marketSegment } = this.state;

    const indexes = Object.keys(marketSegment.segment_questions);
    const nextIndex = parseInt(indexes[indexes.length - 1], 10) + 1 || 0;

    this.setState(
      (prevState) => ({
        marketSegment: {
          ...prevState.marketSegment,
          segment_questions: {
            ...prevState.marketSegment.segment_questions,
            [nextIndex]: '',
          },
        },
      }),
      () => this.sendData(),
    );
  };

  deleteMarketSegment = (index) => {
    const { marketSegment } = this.state;

    const segmentQuestions = marketSegment.segment_questions;
    delete segmentQuestions[index];

    this.setState(
      (prevState) => ({
        marketSegment: { ...prevState.marketSegment, segment_questions: segmentQuestions },
      }),
      () => this.sendData(),
    );
  };

  handleMarketSegmentQuestionsChange = (index, value) => {
    this.setState(
      (prevState) => ({
        marketSegment: {
          ...prevState.marketSegment,
          segment_questions: {
            ...prevState.marketSegment.segment_questions,
            [index]: value,
          },
        },
      }),
      () => this.sendData(),
    );
  };

  handleProblemOpenQuestionChange = (value) => {
    this.setState(
      (prevState) => ({
        problemStatement: {
          ...prevState.problemStatement,
          open_ended_question: value,
        },
      }),
      () => this.sendData(),
    );
  };

  addProblemStatement = () => {
    const { problemStatement } = this.state;

    const indexes = Object.keys(problemStatement.problem_segments);
    const nextIndex = parseInt(indexes[indexes.length - 1], 10) + 1 || 0;

    this.setState(
      (prevState) => ({
        problemStatement: {
          ...prevState.problemStatement,
          problem_segments: {
            ...prevState.problemStatement.problem_segments,
            [nextIndex]: '',
          },
        },
      }),
      () => this.sendData(),
    );
  };

  deleteProblemStatement = (index) => {
    const { problemStatement } = this.state;

    const problemSegments = problemStatement.problem_segments;
    delete problemSegments[index];

    this.setState(
      (prevState) => ({
        problemStatement: { ...prevState.problemStatement, problem_segments: problemSegments },
      }),
      () => this.sendData(),
    );
  };

  handleProblemSegmentQuestionsChange = (index, value) => {
    this.setState(
      (prevState) => ({
        problemStatement: {
          ...prevState.problemStatement,
          problem_segments: {
            ...prevState.problemStatement.problem_segments,
            [index]: value,
          },
        },
      }),
      () => this.sendData(),
    );
  };

  handleSolutionOpenQuestionChange = (value) => {
    this.setState(
      (prevState) => ({
        solutionStatement: {
          ...prevState.solutionStatement,
          open_ended_question: value,
        },
      }),
      () => this.sendData(),
    );
  };

  addSolutionStatement = () => {
    const { solutionStatement } = this.state;

    const indexes = Object.keys(solutionStatement.solution_segments);
    const nextIndex = parseInt(indexes[indexes.length - 1], 10) + 1 || 0;

    this.setState(
      (prevState) => ({
        solutionStatement: {
          ...prevState.solutionStatement,
          solution_segments: {
            ...prevState.solutionStatement.solution_segments,
            [nextIndex]: '',
          },
        },
      }),
      () => this.sendData(),
    );
  };

  deleteSolutionStatement = (index) => {
    const { solutionStatement } = this.state;
    const solutionSegments = solutionStatement.solution_segments;

    delete solutionSegments[index];

    this.setState(
      (prevState) => ({
        solutionStatement: { ...prevState.solutionStatement, solution_segments: solutionSegments },
      }),
      () => this.sendData(),
    );
  };

  handleSolutionSegmentQuestionsChange = (index, value) => {
    this.setState(
      (prevState) => ({
        solutionStatement: {
          ...prevState.solutionStatement,
          solution_segments: {
            ...prevState.solutionStatement.solution_segments,
            [index]: value,
          },
        },
      }),
      () => this.sendData(),
    );
  };

  handleFeedbackTextInputChange = (property, value) => {
    this.setState(
      (prevState) => ({
        feedback: { ...prevState.feedback, [property]: value },
      }),
      () => this.sendData(),
    );
  };

  handleFeedbackOpenQuestionChange = (value) => {
    this.setState(
      (prevState) => ({
        feedback: { ...prevState.feedback, open_ended_question: value },
      }),
      () => this.sendData(),
    );
  };

  handleFeedbackTestingChange = (value) => {
    this.setState(
      (prevState) => ({
        feedback: { ...prevState.feedback, ask_for_testing: value },
      }),
      () => this.sendData(),
    );
  };

  handleFeedbackEmailChange = (value) => {
    this.setState(
      (prevState) => ({
        feedback: { ...prevState.feedback, ask_for_email: value },
      }),
      () => this.sendData(),
    );
  };

  // ToDo: refactor boolean questions into one function

  handleEndingTextInputChange = (property, value) => {
    this.setState(
      (prevState) => ({
        ending: { ...prevState.ending, [property]: value },
      }),
      () => this.sendData(),
    );
  };

  handleEndingBooleanQuestionChange = (value) => {
    this.setState(
      (prevState) => ({
        ending: { ...prevState.ending, include_sharing: value },
      }),
      () => this.sendData(),
    );
  };

  render() {
    const {
      introduction,
      marketSegment,
      solutionStatement,
      problemStatement,
      feedback,
      ending,
      introductionIsOpen,
      marketSegmentIsOpen,
      problemStatementIsOpen,
      solutionStatementIsOpen,
      feedbackIsOpen,
      endingIsOpen,
      introductionImage,
    } = this.state;

    return (
      <>
        <form>
          <div className="flex mb-4">
            <div className="w-1/2 bg-gray-100">
              <button
                type="button"
                onClick={this.showIntroduction}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  introductionIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Introduction to survey
                </h1>

              </button>
              <EditorIntroduction
                introduction={introduction}
                isOpen={introductionIsOpen}
                handleIntroductionTextInputChange={this.handleIntroductionTextInputChange}
                handleIntroductionImageInputChange={this.handleIntroductionImageInputChange}
              />

              <button
                type="button"
                onClick={this.showMarketSegment}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  marketSegmentIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Market segment
                </h1>
              </button>
              <EditorMarketSegment
                marketSegment={marketSegment}
                isOpen={marketSegmentIsOpen}
                openModal={this.openModal}
                handleMarketOpenQuestionChange={this.handleMarketOpenQuestionChange}
                addMarketSegment={this.addMarketSegment}
                deleteMarketSegment={this.deleteMarketSegment}
                handleMarketSegmentQuestionsChange={this.handleMarketSegmentQuestionsChange}
              />

              <button
                type="button"
                onClick={this.showProblemStatement}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  problemStatementIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Problem statement
                </h1>
              </button>
              <EditorProblemStatement
                problemStatement={problemStatement}
                isOpen={problemStatementIsOpen}
                openModal={this.openModal}
                handleProblemSegmentQuestionsChange={this.handleProblemSegmentQuestionsChange}
                addProblemStatement={this.addProblemStatement}
                deleteProblemStatement={this.deleteProblemStatement}
                handleProblemOpenQuestionChange={this.handleProblemOpenQuestionChange}
              />

              <button
                type="button"
                onClick={this.showSolutionStatement}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  solutionStatementIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Solution statement
                </h1>
              </button>
              <EditorSolutionStatement
                solutionStatement={solutionStatement}
                isOpen={solutionStatementIsOpen}
                openModal={this.openModal}
                handleSolutionSegmentQuestionsChange={this.handleSolutionSegmentQuestionsChange}
                addSolutionStatement={this.addSolutionStatement}
                deleteSolutionStatement={this.deleteSolutionStatement}
                handleSolutionOpenQuestionChange={this.handleSolutionOpenQuestionChange}
              />

              <button
                type="button"
                onClick={this.showFeedback}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  feedbackIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Call to action
                </h1>
              </button>
              <EditorFeedback
                feedback={feedback}
                isOpen={feedbackIsOpen}
                handleFeedbackTextInputChange={this.handleFeedbackTextInputChange}
                handleFeedbackOpenQuestionChange={this.handleFeedbackOpenQuestionChange}
                handleFeedbackTestingChange={this.handleFeedbackTestingChange}
                handleFeedbackEmailChange={this.handleFeedbackEmailChange}
              />

              <button
                type="button"
                onClick={this.showEnding}
                className={`focus:outline-none bg-white w-full h-16 p-4 border text-left ${
                  endingIsOpen ? 'hidden' : 'block'
                }`}
              >
                <h1 className="text-primary-500 font-bold mb-3 pt-1 px-4 xl:px-12">
                  Thank you screen
                </h1>
              </button>
              <EditorEnding
                ending={ending}
                isOpen={endingIsOpen}
                handleEndingTextInputChange={this.handleEndingTextInputChange}
                handleEndingBooleanQuestionChange={this.handleEndingBooleanQuestionChange}
              />
            </div>

            <EditorPreview
              introduction={introduction}
              marketSegment={marketSegment}
              problemStatement={problemStatement}
              solutionStatement={solutionStatement}
              feedback={feedback}
              ending={ending}
              introductionIsOpen={introductionIsOpen}
              marketSegmentIsOpen={marketSegmentIsOpen}
              problemStatementIsOpen={problemStatementIsOpen}
              solutionStatementIsOpen={solutionStatementIsOpen}
              feedbackIsOpen={feedbackIsOpen}
              endingIsOpen={endingIsOpen}
              /* eslint-disable-next-line react/destructuring-assignment */
              shareLink={this.props.share_link}
              introductionImage={introductionImage}
            />
          </div>
        </form>
      </>
    );
  }
}

export default SurveyEditor;
