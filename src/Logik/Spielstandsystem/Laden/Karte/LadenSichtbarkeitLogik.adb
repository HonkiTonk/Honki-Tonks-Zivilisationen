with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SchreibeWeltkarte;

with SpielstandAllgemeinesLogik;

package body LadenSichtbarkeitLogik is
   
   function Felderreihe
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenArrays.SichtbarkeitKoordinatenArray;
      LadenPrüfenExtern : in Boolean)
     return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesSchleifenwert) not in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            null;
            
         elsif
           False = FelderreiheLesen (DateiLadenExtern  => DateiLadenExtern,
                                     KoordinatenExtern => KoordinatenExtern,
                                     SpeziesExtern     => SpeziesSchleifenwert,
                                     LadenPrüfenExtern => LadenPrüfenExtern)
         then
            return False;
            
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end Felderreihe;
   
   
   
   function FelderreiheLesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenArrays.SichtbarkeitKoordinatenArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      LadenPrüfenExtern : in Boolean)
     return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
            
      SystemDatentypenHTSEB.EinByte'Read (Stream (File => DateiLadenExtern),
                                          SichtbarkeitVorhanden);
      
      Potenz := (KoordinatenExtern'Last - 1);
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in reverse KoordinatenExtern'Range loop
         
         if
           SichtbarkeitVorhanden >= 2**Potenz
         then
            Sichtbarkeit := True;
            SichtbarkeitVorhanden := SichtbarkeitVorhanden - 2**Potenz;
            
         else
            Sichtbarkeit := False;
         end if;
               
         Potenz := Potenz - 1;
         
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern (SichtbarkeitSchleifenwert),
                                           SpeziesExtern     => SpeziesExtern,
                                           SichtbarExtern    => Sichtbarkeit);
            
            when False =>
               null;
         end case;
         
      end loop SichtbarkeitSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenSichtbarkeitLogik.FelderreiheLesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FelderreiheLesen;
   
   
   
   function AufteilungSpezieszeile
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernBasis;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      -- VorhandeneSpeziesExtern 1 .. 8 braucht nicht abgefragt werden, weil da da beim Speicherverbrauch immer gilt: Reihe <= Spezeis.
      case
        VorhandeneSpeziesExtern
      is
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
      
   end AufteilungSpezieszeile;
   
   
   
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
