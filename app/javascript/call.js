let localStream = null;
let peer = null;
let existingCall = null;

let constraints = {
  video: {},
  audio: true
};
constraints.video.width = {
  min: 320,
  max: 320
};
constraints.video.height = {
  min: 240,
  max: 240 
};


navigator.mediaDevices.getUserMedia({video: true, audio: true})
    .then(function (stream) {
        $('#myStream').get(0).srcObject = stream;
        localStream = stream;
    }).catch(function (error) {
        console.error('mediaDevice.getUserMedia() error:', error);
        return;
    });

    peer = new Peer({
      key: process.env.SKYWAY_API_KEY,
      debug: 3
  });

  peer.on('open', function(){
    $('#my-id').text(peer.id);
  });

  peer.on('call', function(call){
      call.answer(localStream);
      setupCallEventHandlers(call);
  });

  peer.on('error', function(err){
      alert(err.message);
  });

  window.callRoom = function callRoom(){
    console.log('aaaaa')
    let roomName = $('#join-room').val();
    if (!roomName) {
        return;
    }
    const call = peer.joinRoom(roomName, {mode: 'sfu', stream: localStream});
    setupCallEventHandlers(call);
  };

  window.endRoom = function endRoom(){
      existingCall.close();
  };

  function setupCallEventHandlers(call){
    if (existingCall) {
        existingCall.close();
    };

    existingCall = call;
    setupEndCallUI();
    $('#room-id').text(call.name);

    call.on('stream', function(stream){
        addVideo(stream);
    });

    call.on('peerLeave', function(peerId){
        removeVideo(peerId);
    });

    call.on('close', function(){
        removeAllRemoteVideos();
        setupMakeCallUI();
    });
  }

  function addVideo(stream){
    const videoDom = $('<video autoplay>');
    videoDom.attr('id',stream.peerId);
    videoDom.get(0).srcObject = stream;
    $('.videosContainer').append(videoDom);
  }

  function removeVideo(peerId){
      $('#'+peerId).remove();
  }

  function setupMakeCallUI(){
      $('#make-call').show();
      $('#end-call').hide();
  }

  function setupEndCallUI() {
      $('#make-call').hide();
      $('#end-call').show();
  }

  function removeAllRemoteVideos(){
    $('.videosContainer').empty();
  }


