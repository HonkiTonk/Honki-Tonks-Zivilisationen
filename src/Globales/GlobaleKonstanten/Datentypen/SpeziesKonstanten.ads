with SpeziesDatentypen;

package SpeziesKonstanten is
   pragma Pure;
   
   LeerSpezies : constant SpeziesDatentypen.Spezies_Enum := SpeziesDatentypen.Leer_Spezies_Enum;

   LeerSpeziesnummer : constant Natural := SpeziesDatentypen.Speziesnummern'First;
   
   Speziesanfang : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'First;
   Speziesende : constant Positive := SpeziesDatentypen.SpeziesnummernVorhanden'Last;
      
   type SpeziesanfangLadenSpeichernArray is array (1 .. 3) of SpeziesDatentypen.Spezies_Verwendet_Enum;
   SpeziesanfangSpeichernLaden : constant SpeziesanfangLadenSpeichernArray := (1 => SpeziesDatentypen.Speichern_Laden_Eins_Enum'First,
                                                                               2 => SpeziesDatentypen.Speichern_Laden_Zwei_Enum'First,
                                                                               3 => SpeziesDatentypen.Speichern_Laden_Drei_Enum'First
                                                                              );
   
   type SpeziesendeSpeichernLadenArray is array (1 .. 3) of SpeziesDatentypen.Spezies_Verwendet_Enum;
   SpeziesendeSpeichernLaden : constant SpeziesendeSpeichernLadenArray := (1 => SpeziesDatentypen.Speichern_Laden_Eins_Enum'Last,
                                                                           2 => SpeziesDatentypen.Speichern_Laden_Zwei_Enum'Last,
                                                                           3 => SpeziesDatentypen.Speichern_Laden_Drei_Enum'Last
                                                                          );

end SpeziesKonstanten;
