with Ada.Exceptions;

with DateizugriffssystemHTSEB;
with TextKonstantenHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;

with GrafikDatentypen;
with StadtKonstanten;
with EinheitenKonstanten;
with TextnummernKonstanten;
with SpielstandVariablen;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeGrafiktask;

with LadezeitenLogik;
with SpielstandlisteLogik;
with MeldungFestlegenLogik;
with StandardSpielwerteSetzenLogik;
with LadenKarteLogik;
with UmwandlungenVerzeichnisse;
with LadenAllgemeinesLogik;
with SpielstandAllgemeinesLogik;
with LadenSpezienspezifischesLogik;
with LadenDiplomatieLogik;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
package body LadenLogik is
   
   function Laden
     return Boolean
   is
      use Ada.Exceptions;
   begin
      
      LadenSchleife:
      loop
         
         Spielstandname := SpielstandlisteLogik.Spielstandliste (SpeichernLadenExtern => False);
      
         if
           Spielstandname = TextKonstantenHTSEB.LeerUnboundedString
         then
            return False;
         
         else
            LadezeitenLogik.SpeichernLadenNullsetzen;
            SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Speichern_Laden_Enum);
            
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DateiLaden,
                                                    NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandVariablen.SpielstandartLesen,
                                                                                                                SpielstandnameExtern => Spielstandname));
         end if;
         
         case
           Prüfen (DateiLadenExtern => DateiLaden)
         is
            when False =>
               MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungLadenFehlgeschlagen);
               DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiLaden,
                                                          NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandVariablen.SpielstandartLesen,
                                                                                                                      SpielstandnameExtern => Spielstandname));
               
            when True =>
               StandardSpielwerteSetzenLogik.Standardspielwerte (EinstellungenBehaltenExtern => True);
               
               Set_Index (File => DateiLaden,
                          To   => 1);
               
               Ladevorgang (DateiLadenExtern => DateiLaden);
      
               DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiLaden,
                                                          NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandVariablen.SpielstandartLesen,
                                                                                                                      SpielstandnameExtern => Spielstandname));
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);

               return True;
         end case;
         
      end loop LadenSchleife;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenLogik.Laden: Konnte nicht geladen werden: " & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiLaden,
                                                    NameExtern     => UmwandlungenVerzeichnisse.Spielstandpfad (SpielstandarteExtern => SpielstandVariablen.SpielstandartLesen,
                                                                                                                SpielstandnameExtern => Spielstandname));
         
         return False;
      
   end Laden;
   
   
   
   -- Man könnte das Laden vermutlich deutlich beschleunigen wenn man es nur prüft und dann direkt zuweist statt noch einmal durchzugehen. äöü
   function Prüfen
     (DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      case
        LadenKarteLogik.KarteLaden (LadenPrüfenExtern => False,
                                    DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        LadenAllgemeinesLogik.Aufteilung (LadenPrüfenExtern => False,
                                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      end case;
      
      case
        SpezieswerteLaden (LadenPrüfenExtern => False,
                           DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
            return True;
      end case;
      
   end Prüfen;
   
   
   
   procedure Ladevorgang
     (DateiLadenExtern : in File_Type)
   is begin
               
      Leerwert := LadenKarteLogik.KarteLaden (LadenPrüfenExtern => True,
                                              DateiLadenExtern  => DateiLadenExtern);
               
      Leerwert := LadenAllgemeinesLogik.Aufteilung (LadenPrüfenExtern => True,
                                                    DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Leerwert := SpezieswerteLaden (LadenPrüfenExtern => True,
                                     DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      LadezeitenLogik.SpeichernLadenMaximum;
      
   end Ladevorgang;
   
      
   
   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
          SpielstandAllgemeinesLogik.SpeziesbelegungLesen (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           False = LadenSpezienspezifischesLogik.Aufteilung (LadenPrüfenExtern => LadenPrüfenExtern,
                                                             SpeziesExtern     => SpeziesSchleifenwert,
                                                             DateiLadenExtern  => DateiLadenExtern)
         then
            return False;
            
            
            
         elsif
           False = StädteEinheitenLaden (LadenPrüfenExtern => LadenPrüfenExtern,
                                          SpeziesExtern     => SpeziesSchleifenwert,
                                          DateiLadenExtern  => DateiLadenExtern)
         then
            return False;
               
         elsif
           False = LadenDiplomatieLogik.Diplomatie (LadenPrüfenExtern => LadenPrüfenExtern,
                                                    SpeziesExtern     => SpeziesSchleifenwert,
                                                    DateiLadenExtern  => DateiLadenExtern)
         then
            return False;
            
         else
            null;
         end if;
         
      end loop SpeziesSchleife;
      
      return True;
      
   end SpezieswerteLaden;
   
   
   
   function StädteEinheitenLaden
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
            
      EinheitenDatentypen.Einheitenbereich'Read (Stream (File => DateiLadenExtern),
                                                 VorhandeneEinheiten);
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. VorhandeneEinheiten loop
            
         EinheitenRecords.EinheitenGebautRecord'Read (Stream (File => DateiLadenExtern),
                                                      Einheit);
         
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert),
                                                      EintragExtern              => Einheit);
            
            when False =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      
      
      StadtDatentypen.Städtebereich'Read (Stream (File => DateiLadenExtern),
                                           VorhandeneStädte);
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. VorhandeneStädte loop
         
         StadtRecords.StadtGebautRecord'Read (Stream (File => DateiLadenExtern),
                                              Stadt);
         
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeStadtGebaut.GanzerEintrag (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert),
                                                  EintragExtern            => Stadt);
            
            when False =>
               null;
         end case;
         
      end loop StadtSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenLogik.StädteEinheitenLaden: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
   
   end StädteEinheitenLaden;

end LadenLogik;
