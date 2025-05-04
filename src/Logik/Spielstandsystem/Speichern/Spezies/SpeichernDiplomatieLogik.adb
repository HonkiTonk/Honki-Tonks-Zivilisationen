with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpielRecords;

with LeseDiplomatie;

package body SpeichernDiplomatieLogik is

   function Diplomatie
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => DiplomatieSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             DiplomatieSchleifenwert = SpeziesExtern
         then
            null;
                     
         else
            SpielRecords.DiplomatieRecord'Write (Stream (File => DateiSpeichernExtern),
                                                 LeseDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                                                               SpeziesZweiExtern => DiplomatieSchleifenwert));
         end if;

      end loop DiplomatieSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernDiplomatieLogik.Diplomatie: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Diplomatie;

end SpeichernDiplomatieLogik;
