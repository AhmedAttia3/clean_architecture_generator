const flowState = 'FlowState';

const loadingState = 'const LoadingState(type: LoadingRendererType.popup)';

const contentState = 'const ContentState()';

const successState =
    'SuccessState(message: data.message,type: SuccessRendererType.content,)';

const errorState =
    'ErrorState(type: ErrorRendererType.toast,message: data.message,)';

const errorFailureState =
    'ErrorState(type: ErrorRendererType.toast,message: failure.message,)';

const successStateTest =
    'SuccessState(message: "message",type: SuccessRendererType.content,)';

const errorStateTest =
    'ErrorState(type: ErrorRendererType.toast,message: "message",)';
