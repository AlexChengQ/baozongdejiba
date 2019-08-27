// 这段代码是固定的，必须要放到js?
function setupAndroidWebViewJavascriptBridge(callback,arguments) {
	eval(callback)(JSON.parse(arguments));
}
var	App = function () {
	var userAgentInfo = navigator.userAgent;
	return {
		openModal:function(url,height){
			if (userAgentInfo.indexOf("android") == 0){
				app.openModal(JSON.stringify(url), height);
			} else if (userAgentInfo.indexOf("ios") == 0){
				
			} else {
			}
		},

		selectDate:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.selectDate(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.selectDate(config);
			} else {
			}
		},
		selectTime:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.selectTime(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.selectTime(config);
			} 
			 else { 

			}
		},
		selectImage:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.selectPic(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.selectImage(config);
			} 
		},
		selectImg:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.selectImage(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.selectImage(config);
			} 
		},
		readFile:function(path){
			if (userAgentInfo.indexOf("android") == 0){
				return  app.readFile(path);
			} else if (userAgentInfo.indexOf("ios") == 0){
				return path;
			} 
		},
        getNavValue:function(index){
			if (userAgentInfo.indexOf("android") == 0){
				return app.getNavValue(index);
			} else if (userAgentInfo.indexOf("ios") == 0){
				return app.getNavValue(index);
			}
		},
		viewPicture:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.viewPic(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.viewPicture(config);
			} 
		},

		callHostPlugin:function(pluginName,method, data){
			if (userAgentInfo.indexOf("android") == 0){
				if (method && data)
					app.callHostPlugin(pluginName, method, JSON.stringify(data));
				else
					app.callHostPlugin(pluginName);
			} else if (userAgentInfo.indexOf("ios") == 0){
				if (method && data){
					app.callHostPlugin({pluginName: pluginName, method:method, data:data});
				}
				else{
					app.callHostPlugin(pluginName);
				}
			} 
		},
		setTopMenu:function(menu){
		    if (userAgentInfo.indexOf("android") == 0){
		        app.setTopRight(JSON.stringify(menu));
		    } else if (userAgentInfo.indexOf("ios") == 0){
		        app.setTopMenu(menu);
		    } else {		    	
		    }
		},
		hideTopMenu:function(){
		    if (userAgentInfo.indexOf("android") == 0){
		        app.hideTopRight();
		    } else if (userAgentInfo.indexOf("ios") == 0){
		    	app.hideTopRight();
		    } else {
		    }
		},
		setTitle:function(title,color){
			var len = arguments.length;
		    if (userAgentInfo.indexOf("android") == 0){
		    	if(len ==2){
		    		app.setTitle(title,"#" + color);
		    	}else{
		    		app.setTitle(title);
		    	}
		    } else if (userAgentInfo.indexOf("ios") == 0){
		        if(len ==2){
		    		app.setTitle({title:title,color:color});
		    	}else{
		    		app.setTitle(title);
		    	}
		    } else {
		    }
		},
		dial:function(number){
			if (userAgentInfo.indexOf("android") == 0){
				app.dial(number);
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.dial(number);
			} 
		},
		setFootMenu:function(menu){
		    if (userAgentInfo.indexOf("android") == 0){
		        app.setFootMenu(JSON.stringify(menu));
		    } else if (userAgentInfo.indexOf("ios") == 0){
		    	app.setFootMenu(menu);
		    } else{
		    }
		},
		openNew:function(url){
			if (userAgentInfo.indexOf("android") == 0){
				app.openNew(JSON.stringify(url));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.openNew(url);
			} else {
			}
		},
		setNav:function(arr){
			if (userAgentInfo.indexOf("android") == 0){
				app.setNavigator(JSON.stringify(arr));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.setNavigator(arr);
			} else {
			}
		},
		close:function(){
			if (userAgentInfo.indexOf("android") == 0){
				app.close();
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.close();
			} else {
			}
		},
		callParent:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.callParent(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.callParent(config);
			} else {
			}
		},
		refreshParent:function(){
			if (userAgentInfo.indexOf("android") == 0){
				app.refreshParent();
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.refreshParent();
			} else {
				window.opener.location.reload();
			}
		},
		dragRefresh:function(){
			if (userAgentInfo.indexOf("android") == 0){
				app.dragRefresh();
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.dragRefresh();
			} else {
			}
		},
		prompt:function(message){
			if (userAgentInfo.indexOf("android") == 0){
				app.prompt(''+message);
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.prompt(message);
			} else {
			}
		},
		alert:function(message){
			if (userAgentInfo.indexOf("android") == 0){
				app.alert(message);
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.alert(message);
			} else {
			}
		},
		confirm:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.confirm(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.confirm(config);
			} else {
				if (confirm(config.message)){
					if (config.params)
						eval(config.callback)(config.params);
					else 
						eval(config.callback)();
				}
			}
		},
		selector:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.selector(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.selector(config);
			} else {


			}
		},
		actions:function(config){
			if (userAgentInfo.indexOf("android") == 0){
				app.actions(JSON.stringify(config));
			} else if (userAgentInfo.indexOf("ios") == 0){
				app.actions(config);
			} else {


			}
		},
		getLocation:function(){
            if (userAgentInfo.indexOf("android") == 0){
                return app.getLocation();
            } else if (userAgentInfo.indexOf("ios") == 0){
                return app.getLocation();
            } else {


            }
        },
        onPageEnd:function(){
        	if (userAgentInfo.indexOf("android") == 0){
                if (onPageEnd != undefined)
                	onPageEnd();
            } else if (userAgentInfo.indexOf("ios") == 0){
                if (onPageEnd != undefined)
                	onPageEnd();
            }
        },
         onResume:function(){
             
             if (userAgentInfo.indexOf("android") == 0){
                if (onResume != undefined)
                 onResume();
            } else if (userAgentInfo.indexOf("ios") == 0){
                if (onResume != undefined)
                 onResume();
            }
         },
         onSaveState:function(){
             if (userAgentInfo.indexOf("android") == 0){
                if (onSaveState != undefined)
                 onSaveState();
            } else if (userAgentInfo.indexOf("ios") == 0){
                if (onSaveState != undefined)
                 onSaveState();
            }
         },
         get:function(key){
            if (userAgentInfo.indexOf("android") == 0){
                return app.get(key);
            } else if (userAgentInfo.indexOf("ios") == 0){
                return app.get(key);
            } else {

            }
         },
          remove:function(key){
             if (userAgentInfo.indexOf("android") == 0){
                 app.remove(key);
             } else if (userAgentInfo.indexOf("ios") == 0){
                 app.remove(key);
             } else {

             }
          },
         put:function(key,value){
            if (userAgentInfo.indexOf("android") == 0){
                   app.put(key,value);
               } else if (userAgentInfo.indexOf("ios") == 0){
                   app.put({key:key,value:value});
               } else {


               }
         },
         debug:function(){
             if (userAgentInfo.indexOf("android") == 0){
                    app.debug();
                } else if (userAgentInfo.indexOf("ios") == 0){
                    app.debug();
                } else {


                }
          },
          showLoading:function(second, callback){
              if (userAgentInfo.indexOf("android") == 0){
                if (callback != undefined)
                    app.showLoading(second, callback);
                else
                    app.showLoading(second,"");

              } else if (userAgentInfo.indexOf("ios") == 0){
              	if (callback != undefined)
                    app.showLoading(second, callback);
                else
                    app.showLoading(second,"");
              } else {

              }
           },
           hideLoading:function(){
              if (userAgentInfo.indexOf("android") == 0){
                  setTimeout("app.hideLoading()",2000);
              } else if (userAgentInfo.indexOf("ios") == 0){
                  //setTimeout("app.hideLoading()",2000);
            	  app.hideLoading();
              } else {

              }
           },
           acceptMessage:function(action){
                if (userAgentInfo.indexOf("android") == 0){
                    app.acceptMessage(action);
               } else if (userAgentInfo.indexOf("ios") == 0){
               		app.acceptMessage(action);
               } else {


                }
           },
           calendar:function(config){
               if (userAgentInfo.indexOf("android") == 0){
                   app.selectCalendar(JSON.stringify(config));
               } else if (userAgentInfo.indexOf("ios") == 0){
                   app.selectCalendar(config);
               }else {

               }
           },
           show2dCode:function(data){
               if (userAgentInfo.indexOf("android") == 0){
                   app.show2dCode(data);
               } else if (userAgentInfo.indexOf("ios") == 0){
               		app.show2dCode(data);
               }
                else {

               }
           },
           closeParent:function(){
   			if (userAgentInfo.indexOf("android") == 0){
   				app.closeParent();
   			} else if (userAgentInfo.indexOf("ios") == 0){
   				app.closeParent();
   			} else {		    	
   			}
   		},
   		setBottomBadge:function(index,str){//
     	   if (userAgentInfo.indexOf("android") == 0){
     		   app.setBottomBadge(index,str);
     	   } else if (userAgentInfo.indexOf("ios") == 0){
     	   		app.setBottomBadge({index:index, str:str});
     	   }
     	   else {
     		   
     	   }
        },
        setTitleIcon:function(icon){
	   		    if (userAgentInfo.indexOf("android") == 0){
	   		        app.setTitleIcon(icon);
	   		    } else if (userAgentInfo.indexOf("ios") == 0){
	   		    	app.setTitleIcon(icon);
	   		    }
        },
        setNavMenu:function(icon,menu){
          	if (userAgentInfo.indexOf("android") == 0){
          	  app.setNavMenu(icon,JSON.stringify(menu));
          	} else if (userAgentInfo.indexOf("ios") == 0){
          	  app.setNavMenu(icon,menu);
          	} else {
          	}
         },
        setToken:function(v){
         	if (userAgentInfo.indexOf("android") == 0){
                   	  app.setToken(v);
                   	} else if (userAgentInfo.indexOf("ios") == 0){
                   	  app.setToken(v);
                   	} else {
                   	}
         },
         openNewWithFlag:function(url,v){
             if (userAgentInfo.indexOf("android") == 0){
                 app.openNewWithFlag(JSON.stringify(url),v);
             } else if (userAgentInfo.indexOf("ios") == 0){
                 app.openNew(url);
             } else {
             }
         },
         auth:function(val){
                  	if (userAgentInfo.indexOf("android") == 0){
                   	  app.auth(JSON.stringify(val));
                 	} else if (userAgentInfo.indexOf("ios") == 0){
                 	  app.auth(val);
                 	} else {
                 	}
                 },
         share:function(val){
               	if (userAgentInfo.indexOf("android") == 0){
                         	  app.share(JSON.stringify(val));
             	} else if (userAgentInfo.indexOf("ios") == 0){
             	  app.share(val);
             	} else {
             	}
         }
     }
}();


