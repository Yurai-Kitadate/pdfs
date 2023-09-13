import speech_recognition as sr

#ユーザーから動画のパスを入力してもらう
    video_path = input("動画のパスを入力してください：")

#音声認識を行う
                           r = sr.Recognizer()
                                                 with sr.AudioFile(video_path) as source:audio = r.record(source)

#認識結果を出力する
                                                                                                              text = r.recognize_google(audio, language = 'ja-JP')
                                                                                                                                            print("解析結果：", text)
