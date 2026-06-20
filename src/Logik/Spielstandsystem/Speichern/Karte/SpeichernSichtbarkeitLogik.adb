with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesKonstanten;
with SystemKonstanten;

with LeseWeltkarte;
with LeseSpeziesbelegung;

package body SpeichernSichtbarkeitLogik is
   
   procedure Leersetzung
   is begin
      
      SichtbarkeitGesamt := (others => (others => False));
      
   end Leersetzung;
   
   
   
   procedure Sichtbarkeitsbelegung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      FelderanzahlExtern : in Positive)
   is begin
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         SichtbarkeitGesamt (SichtbarkeitSchleifenwert, FelderanzahlExtern) := LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                                                                                       SpeziesExtern     => SichtbarkeitSchleifenwert);
         
      end loop SichtbarkeitSchleife;
      
   end Sichtbarkeitsbelegung;
   
   
   
   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) not in SpeziesDatentypen.Spieler_Belegt_Enum'Range
         then
            null;
            
         elsif
           False = SichtbarkeitSchreiben (DateiSpeichernExtern => DateiSpeichernExtern,
                                          SichtbarkeitExtern   => SichtbarkeitGesamt,
                                          SpeziesExtern        => SpeziesSchleifenwert)
         then
            return False;
            
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end Aufteilung;
   
   
   
   function SichtbarkeitSchreiben
     (DateiSpeichernExtern : in File_Type;
      SichtbarkeitExtern : in KartenArrays.SichtbarkeitGesamtArray;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      SichtbarkeitVorhanden := 0;
      AktuelleSichtbarkeit := 1;
      
      SichtbarkeitSchleife:
      for SichtbarkeitSchleifenwert in SichtbarkeitExtern'Range (2) loop
         
         case
           SichtbarkeitExtern (SpeziesExtern, SichtbarkeitSchleifenwert)
         is
            when True =>
               SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
            when False =>
               null;
         end case;
         
         AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
         
      end loop SichtbarkeitSchleife;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                           SichtbarkeitVorhanden);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.SichtbarkeitSchreiben: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitSchreiben;
   
   
   
   function SpeicherverbrauchErmitteln
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VorhandeneSpeziesExtern : in SpeziesDatentypen.SpeziesnummernVorhanden)
      return Positive
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
         return 1;

      elsif
        UnsichtbarSpezies = VorhandeneSpeziesExtern
      then
         return 1;

      else
         VorhandeneSpezies := SpeziesKonstanten.LeerSpeziesnummer;

         SichtbarkeitVorhandenVorzeichen := 0;
         AktuelleSichtbarkeitVorzeichen := 1;
         
         Speicherverbrauch := 0;
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
               Speicherverbrauch := Speicherverbrauch + 1;
               
               exit SichtbarkeitSchleife;

            elsif
              VorhandeneSpezies mod 7 = 0
            then
               Speicherverbrauch := Speicherverbrauch + 1;
               
               SichtbarkeitVorhandenVorzeichen := 0;
               AktuelleSichtbarkeitVorzeichen := 1;

            else
               AktuelleSichtbarkeitVorzeichen := AktuelleSichtbarkeitVorzeichen * 2;
            end if;

         else
            null;
         end if;

      end loop SichtbarkeitSchleife;
      
      return Speicherverbrauch;
      
   end SpeicherverbrauchErmitteln;



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
