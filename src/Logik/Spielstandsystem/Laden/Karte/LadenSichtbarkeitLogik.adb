with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with SystemDatentypenHTSEB;

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
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          SichtbarkeitVorhanden (1));
            
      case
        VorhandeneSpeziesExtern
      is
         when 0 =>
            return False;
            
         when 9 .. 16 =>
            AktuellerArraybereich := 2;
            
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitVorhanden (2));
              
         when 17 .. 18 =>
            AktuellerArraybereich := 3;
            
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitVorhanden (2));
            SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                                SichtbarkeitVorhanden (3));
            
         when others =>
            AktuellerArraybereich := 1;
      end case;
      
      VorhandeneSpezies := VorhandeneSpeziesExtern;
      GesamteSichtbarkeit := (others => False);
            
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               Potenz := (VorhandeneSpezies - 1) mod 8;
               
               if
                 SichtbarkeitVorhanden (AktuellerArraybereich) >= 2**Potenz
               then
                  GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                  SichtbarkeitVorhanden (AktuellerArraybereich) := SichtbarkeitVorhanden (AktuellerArraybereich) - 2**Potenz;
            
               else
                  null;
               end if;
               
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
                  AktuellerArraybereich := AktuellerArraybereich - 1;
                  
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.Sichtbarkeit: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Sichtbarkeit;

end LadenSichtbarkeitLogik;
