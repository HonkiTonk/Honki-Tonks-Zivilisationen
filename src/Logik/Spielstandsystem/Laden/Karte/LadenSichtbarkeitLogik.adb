with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SchreibeWeltkarte;

with SpielstandAllgemeinesLogik;

package body LadenSichtbarkeitLogik is
   
   function Sichtbarkeit
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      case
        VorhandeneSpeziesExtern
      is
         when others =>
            null;
      end case;
      
      SichtbarkeitVorhanden := 0;
      GesamteSichtbarkeit := (others => False);
         
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               if
                 SichtbarkeitVorhanden = 0
               then
                  SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                      SichtbarkeitVorhanden);
                  
               else
                  null;
               end if;
               
               ErmittelnSchleife:
               for ErmittelSchleifenwert in reverse 0 .. 7 loop
            
                  if
                    SichtbarkeitVorhanden >= 2**ErmittelSchleifenwert
                  then
                     GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                     SichtbarkeitVorhanden := SichtbarkeitVorhanden - 2**ErmittelSchleifenwert;
                     exit ErmittelnSchleife;
            
                  else
                     null;
                  end if;
            
               end loop ErmittelnSchleife;
               
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
         end case;
         
      end loop SichtbarkeitSchleife;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.GesamteSichtbarkeit (KoordinatenExtern  => KoordinatenExtern,
                                                   SichtbarkeitExtern => GesamteSichtbarkeit);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.Sichtbarkeit: Konnte nicht geladen werden: LadenPrüfenExtern =" & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Sichtbarkeit;

end LadenSichtbarkeitLogik;
