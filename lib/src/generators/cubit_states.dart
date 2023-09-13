const flowState = 'FlowState';

const loadingState = 'LoadingState(type: StateRendererType.fullScreenLoading)';

const contentState = 'ContentState()';

const successState =
    'SuccessState(message: data.message,type: StateRendererType.contentState,)';

const errorState =
    'ErrorState(type: StateRendererType.toastError,message: data.message,)';

const errorFailureState =
    'ErrorState(type: StateRendererType.toastError,message: failure.message,)';

const successStateTest =
    'SuccessState(message: "message",type: StateRendererType.contentState,)';

const errorStateTest =
    'ErrorState(type: StateRendererType.toastError,message: "message",)';
