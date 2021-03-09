import Vue from 'vue/dist/vue.esm'
import Group from '../call.js'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#group',
    data: {
    },
    components: { Group }
  })
})