with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenRecords;
with SpielRecords;

with LeseWichtiges;
with LeseGrenzen;
with LeseZeiger;

package body SpeichernSpezienspezifischesLogik is

   function Spezienspezifisches
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
   
      SpielRecords.GrenzenRecord'Write (Stream (File => DateiSpeichernExtern),
                                        LeseGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      SpielRecords.WichtigesRecord'Write (Stream (File => DateiSpeichernExtern),
                                          LeseWichtiges.GanzerEintrag (SpeziesExtern => SpeziesExtern));
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            KartenRecords.ZeigerRecord'Write (Stream (File => DateiSpeichernExtern),
                                              LeseZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern));
            
         when others =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSpezienspezifischesLogik.Spezienspezifisches: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Spezienspezifisches;

end SpeichernSpezienspezifischesLogik;
