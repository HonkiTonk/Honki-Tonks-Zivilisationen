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
         when 0 =>
            return False;
            
         when others =>
            SichtbarkeitVorhanden := 0;
            VorhandeneSpezies := VorhandeneSpeziesExtern;
            GesamteSichtbarkeit := (others => False);
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitVorhanden);
      end case;
            
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               ErmittelnSchleife:
                -- 0 .. VorhandeneSpezies mod 8? Müsste hinhauen, oder? äöü
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
               
               VorhandeneSpezies := VorhandeneSpezies - 1;
               
               if
                 VorhandeneSpezies = 0
               then
                  exit SichtbarkeitSchleife;
                  
               elsif
                 VorhandeneSpezies = 16
                 or
                   VorhandeneSpezies = 8
               then
                  SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                      SichtbarkeitVorhanden);
                  
               else
                  null;
               end if;
               
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
