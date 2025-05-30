with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SchreibeWeltkarte;

with SpielstandAllgemeinesLogik;

package body LadenSichtbarkeitLogik is
   
   function Aufteilung
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        VorhandeneSpeziesExtern
      is
         when 1 .. 8 =>
            return SichtbarkeitEinByte (DateiLadenExtern        => DateiLadenExtern,
                                        KoordinatenExtern       => KoordinatenExtern,
                                        VorhandeneSpeziesExtern => VorhandeneSpeziesExtern,
                                        LadenPrüfenExtern       => LadenPrüfenExtern);
              
         when 15 .. 16 =>
            return SichtbarkeitZweiByte (DateiLadenExtern        => DateiLadenExtern,
                                         KoordinatenExtern       => KoordinatenExtern,
                                         VorhandeneSpeziesExtern => VorhandeneSpeziesExtern,
                                         LadenPrüfenExtern       => LadenPrüfenExtern);
            
         when 9 .. 14 | 17 .. 18 =>
            return SichtbarkeitVorzeichen (DateiLadenExtern        => DateiLadenExtern,
                                           KoordinatenExtern       => KoordinatenExtern,
                                           VorhandeneSpeziesExtern => VorhandeneSpeziesExtern,
                                           LadenPrüfenExtern       => LadenPrüfenExtern);
            
         when others =>
            return False;
      end case;
      
   end Aufteilung;
   
   
   
   function SichtbarkeitEinByte
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      GesamteSichtbarkeit := (others => False);
      Potenz := (VorhandeneSpeziesExtern - 1);
      
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          SichtbarkeitVorhanden);
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               if
                 SichtbarkeitVorhanden >= 2**Potenz
               then
                  GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden - 2**Potenz;
            
               else
                  null;
               end if;
               
               Potenz := Potenz - 1;
               
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.SichtbarkeitEinByte: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitEinByte;
   
   
   
   function SichtbarkeitZweiByte
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.ZweiByte;
   begin
      
      SystemDatentypenHTSEB.ZweiByte'Read (Stream (File => DateiLadenExtern),
                                           SichtbarkeitVorhandenZweiByte);
      
      GesamteSichtbarkeit := (others => False);
      Potenz := (VorhandeneSpeziesExtern - 1);
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               if
                 SichtbarkeitVorhandenZweiByte >= 2**Potenz
               then
                  GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                  SichtbarkeitVorhandenZweiByte := SichtbarkeitVorhandenZweiByte - 2**Potenz;
                  
               else
                  null;
               end if;
               
               Potenz := Potenz - 1;
               
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.SichtbarkeitZweiByte: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end SichtbarkeitZweiByte;
   
   
   
   function SichtbarkeitVorzeichen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByteVorzeichen;
   begin
      
      SystemDatentypenHTSEB.EinByteVorzeichen'Read (Stream (File => DateiLadenExtern),
                                                    SichtbarkeitVorhandenVorzeichen (1));
      
      case
        SichtbarkeitVorhandenVorzeichen (1)
      is
         when SystemKonstanten.AllesSichtbar | SystemKonstanten.AllesUnsichtbar =>
            if
              LadenPrüfenExtern
            then
               SchreibeWeltkarte.GesamteSichtbarkeit (KoordinatenExtern  => KoordinatenExtern,
                                                      SichtbarkeitExtern => (others => SichtbarkeitGleich (SichtbarkeitVorhandenVorzeichen (1))));
            
            else
               null;
            end if;
            
            return True;
            
         when others =>
            VorhandeneSpezies := VorhandeneSpeziesExtern;
            GesamteSichtbarkeit := (others => False);
            
            SystemDatentypenHTSEB.EinByteVorzeichen'Read (Stream (File => DateiLadenExtern),
                                                          SichtbarkeitVorhandenVorzeichen (2));
      end case;
      
      case
        VorhandeneSpeziesExtern
      is
            
         when 9 .. 14 =>
            AktuellerArraybereich := 2;
              
         when 17 .. 18 =>
            AktuellerArraybereich := 3;
            
            SystemDatentypenHTSEB.EinByteVorzeichen'Read (Stream (File => DateiLadenExtern),
                                                          SichtbarkeitVorhandenVorzeichen (3));
            
         when others =>
            return False;
      end case;
            
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SichtbarkeitSchleifenwert)
         is
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               Potenz := (VorhandeneSpezies - 1) mod 7;
               
               if
                 SichtbarkeitVorhandenVorzeichen (AktuellerArraybereich) >= 2**Potenz
               then
                  GesamteSichtbarkeit (SichtbarkeitSchleifenwert) := True;
                  SichtbarkeitVorhandenVorzeichen (AktuellerArraybereich) := SichtbarkeitVorhandenVorzeichen (AktuellerArraybereich) - 2**Potenz;
            
               else
                  null;
               end if;
               
               VorhandeneSpezies := VorhandeneSpezies - 1;
               
               if
                 VorhandeneSpezies = 0
               then
                  exit SichtbarkeitSchleife;
                  
               elsif
                 VorhandeneSpezies = 14
                 or
                   VorhandeneSpezies = 7
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.SichtbarkeitVorzeichen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitVorzeichen;

end LadenSichtbarkeitLogik;
