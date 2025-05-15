with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SchreibeDiplomatie;

with SpielstandAllgemeinesLogik;

package body LadenDiplomatieLogik is

   function Diplomatie
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type SpeziesDatentypen.Spieler_Enum;
   begin
            
      DiplomatieSchleife:
      for SpeziesDiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

         if
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesDiplomatieSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesExtern = SpeziesDiplomatieSchleifenwert
         then
            null;
            
         else
            SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                Diplomatieeintrag);
            
            case
              LadenPrüfenExtern
            is
               when True =>
                  SchreibeDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                                    SpeziesZweiExtern => SpeziesDiplomatieSchleifenwert,
                                                    EintragExtern     => Diplomatieeintrag);
            
               when False =>
                  null;
            end case;
         end if;

      end loop DiplomatieSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenDiplomatieLogik.Diplomatie: Konnte nicht geladen werden: LadenPrüfenExtern =" & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Diplomatie;

end LadenDiplomatieLogik;
