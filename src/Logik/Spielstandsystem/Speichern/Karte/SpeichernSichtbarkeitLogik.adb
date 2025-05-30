with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;
with SystemKonstanten;

with LeseWeltkarte;
with LeseSpeziesbelegung;

package body SpeichernSichtbarkeitLogik is
   
   function Aufteilung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.Speziesnummern;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        VorhandeneSpeziesExtern
      is
         when 1 .. 8 =>
            return SichtbarkeitEinByte (KoordinatenExtern    => KoordinatenExtern,
                                        DateiSpeichernExtern => DateiSpeichernExtern);
            
         when 15 .. 16 =>
            return SichtbarkeitZweiByte (KoordinatenExtern       => KoordinatenExtern,
                                         DateiSpeichernExtern    => DateiSpeichernExtern);
            
         when 9 .. 14 | 17 .. 18 =>
            return SichtbarkeitVorzeichen (KoordinatenExtern       => KoordinatenExtern,
                                           VorhandeneSpeziesExtern => VorhandeneSpeziesExtern,
                                           DateiSpeichernExtern    => DateiSpeichernExtern);
            
         when others =>
            return False;
      end case;
      
   end Aufteilung;
   
   
   
   function SichtbarkeitEinByte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      SichtbarkeitVorhanden := 0;
      AktuelleSichtbarkeit := 1;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
               when False =>
                  null;
            end case;
            
            AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
                        
         else
            null;
         end if;
         
      end loop SichtbarkeitSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           SichtbarkeitVorhanden);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.SichtbarkeitEinByte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitEinByte;
   
   
   
   function SichtbarkeitZweiByte
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.ZweiByte;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      SichtbarkeitVorhandenZweiByte := 0;
      AktuelleSichtbarkeitZweiByte := 1;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhandenZweiByte := SichtbarkeitVorhandenZweiByte + AktuelleSichtbarkeitZweiByte;
               
               when False =>
                  null;
            end case;
            
            AktuelleSichtbarkeitZweiByte := AktuelleSichtbarkeitZweiByte * 2;
            
         else
            null;
         end if;
         
      end loop SichtbarkeitSchleife;
      
      SystemDatentypenHTSEB.ZweiByte'Write (Stream (File => DateiSpeichernExtern),
                                            SichtbarkeitVorhandenZweiByte);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.SichtbarkeitZweiByte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitZweiByte;
   
   
   
   function SichtbarkeitVorzeichen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByteVorzeichen;
   begin
      
      SichtbarSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      UnsichtbarSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      SichtbarkeitPrüfenSchleife:
      for SichtbarkeitPrüfenSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitPrüfenSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitPrüfenSchleifenwert)
            is
               when True =>
                  SichtbarSpezies := SichtbarSpezies + 1;
                  
               when False =>
                  UnsichtbarSpezies := UnsichtbarSpezies + 1;
            end case;
                                    
         else
            null;
         end if;
         
      end loop SichtbarkeitPrüfenSchleife;
      
      if
        SichtbarSpezies = VorhandeneSpeziesExtern
      then
         SystemDatentypenHTSEB.EinByteVorzeichen'Write (Stream (File => DateiSpeichernExtern),
                                                        SystemKonstanten.AllesSichtbar);
         return True;
         
      elsif
        UnsichtbarSpezies = VorhandeneSpeziesExtern
      then
         SystemDatentypenHTSEB.EinByteVorzeichen'Write (Stream (File => DateiSpeichernExtern),
                                                        SystemKonstanten.AllesUnsichtbar);
         return True;
            
      else
         VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;
      
         SichtbarkeitVorhandenVorzeichen := 0;
         AktuelleSichtbarkeitVorzeichen := 1;
      end if;
            
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SichtbarkeitSchleifenwert) in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhandenVorzeichen := SichtbarkeitVorhandenVorzeichen + AktuelleSichtbarkeitVorzeichen;
               
               when False =>
                  null;
            end case;
            
            VorhandeneSpezies := VorhandeneSpezies + 1;
            
            if
              VorhandeneSpezies = VorhandeneSpeziesExtern
            then
               SystemDatentypenHTSEB.EinByteVorzeichen'Write (Stream (File => DateiSpeichernExtern),
                                                              SichtbarkeitVorhandenVorzeichen);
               exit SichtbarkeitSchleife;
         
            elsif
              VorhandeneSpezies mod 7 = 0
            then
               SystemDatentypenHTSEB.EinByteVorzeichen'Write (Stream (File => DateiSpeichernExtern),
                                                              SichtbarkeitVorhandenVorzeichen);
               SichtbarkeitVorhandenVorzeichen := 0;
               AktuelleSichtbarkeitVorzeichen := 1;
                  
            else
               AktuelleSichtbarkeitVorzeichen := AktuelleSichtbarkeitVorzeichen * 2;
            end if;
            
         else
            null;
         end if;
         
      end loop SichtbarkeitSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.SichtbarkeitVorzeichen: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitVorzeichen;

end SpeichernSichtbarkeitLogik;
