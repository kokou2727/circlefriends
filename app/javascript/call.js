  let localStream = null;
  let peer = null;
  let existingCall = null;
  let audioSelect = $('#audioSource');
  let videoSelect = $('#videoSource');

  navigator.mediaDevices.enumerateDevices()
      .then(function(deviceInfos) {
          for (let i = 0; i !== deviceInfos.length; ++i) {
              let deviceInfo = deviceInfos[i];
              let option = $('<option>');
              option.val(deviceInfo.deviceId);
              if (deviceInfo.kind === 'audioinput') {
                  option.text(deviceInfo.label);
                  audioSelect.append(option);
              } else if (deviceInfo.kind === 'videoinput') {
                  option.text(deviceInfo.label);
                  videoSelect.append(option);
              }
          }
          videoSelect.on('change', setupGetUserMedia);
          audioSelect.on('change', setupGetUserMedia);
          setupGetUserMedia();
      }).catch(function (error) {
          console.error('mediaDevices.enumerateDevices() error:', error);
          return;
      });

  peer = new Peer({
      key: process.env.SKYWAY_API_KEY,
      debug: 3
  });

  peer.on('open', function(){
      $('#my-id').text(peer.id);
      setupMuteOnUI()
      setupVideoOffUI()
  });

  peer.on('error', function(err){
      alert(err.message);
  });

  window.roomJoin = function roomJoin(){
      let roomName = (gon.group_name);
      if (!roomName) {
          return;
      }
      const call = peer.joinRoom(roomName, {mode: 'sfu', stream: localStream});
      setupCallEventHandlers(call);
  };

  window.endRoom = function endRoom(){
      existingCall.close();
  };

  function setupGetUserMedia() {
      let audioSource = $('#audioSource').val();
      let videoSource = $('#videoSource').val();
      let constraints = {
          audio: {deviceId: {exact: audioSource}},
          video: {deviceId: {exact: videoSource}}
      };
      constraints.video.width = {
          min: 320,
          max: 320
      };
      constraints.video.height = {
          min: 240,
          max: 240        
      };

      if(localStream){
          localStream = null;
      }

      navigator.mediaDevices.getUserMedia(constraints)
          .then(function (stream) {
              $('#myStream').get(0).srcObject = stream;
              localStream = stream;

              if(existingCall){
                  existingCall.replaceStream(stream);
              }

          }).catch(function (error) {
              console.error('mediaDevice.getUserMedia() error:', error);
              return;
          });
  }

  function setupCallEventHandlers(call){
      if (existingCall) {
          existingCall.close();
      };

      existingCall = call;
      setupEndCallUI();
      $('#room-id').text(gon.group_name);

      call.on('stream', function(stream){
          addVideo(stream);
      });

      call.on('removeStream', function(stream){
          removeVideo(stream.peerId);
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

  function removeAllRemoteVideos(){
      $('.videosContainer').empty();
  }

  function setupMakeCallUI(){
      $('#make-call').show();
      $('#end-call').hide();
  }

  function setupEndCallUI() {
      $('#make-call').hide();
      $('#end-call').show();
  }

  function setupMuteOffUI() {
    $('#mute-on').hide();
    $('#mute-off').show();
  }

  function setupMuteOnUI() {
    $('#mute-on').show();
    $('#mute-off').hide();
  }

  function setupVideoOffUI() {
    $('#video-on').hide();
    $('#video-off').show();
  }

  function setupVideoOnUI() {
    $('#video-on').show();
    $('#video-off').hide();
  }

  window.muteOn = function muteOn(){
    localStream.getAudioTracks().forEach(track => track.enabled = false);
    setupMuteOffUI()
  };

  window.videoOff = function videoOff(){
    localStream.getVideoTracks().forEach(track => track.enabled = false);
    setupVideoOnUI()
  };

  window.muteOff = function muteOff(){
    localStream.getAudioTracks().forEach(track => track.enabled = true);
    setupMuteOnUI()
  };

  window.videoOn = function videoOn(){
    localStream.getVideoTracks().forEach(track => track.enabled = true);
    setupVideoOffUI()
  };