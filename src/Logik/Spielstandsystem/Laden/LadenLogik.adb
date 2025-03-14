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

with SchreibeWichtiges;
with SchreibeGrenzen;
with SchreibeDiplomatie;
with SchreibeZeiger;
with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeAllgemeines;
with SchreibeSpeziesbelegung;
with SchreibeGrafiktask;

with LadezeitenLogik;
with SpielstandlisteLogik;
with MeldungFestlegenLogik;
with StandardSpielwerteSetzenLogik;
with LadenKarteLogik;
with UmwandlungenVerzeichnisse;

-- Bei Änderungen am Ladesystem auch immer das Speichersystem anpassen!
-- Änderungen an den zu ladenden Datentypen kann jederzeit Probleme bei Laden verursachen.
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
        AllgemeinesLaden (LadenPrüfenExtern => False,
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
               
      Leerwert := AllgemeinesLaden (LadenPrüfenExtern => True,
                                    DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      Leerwert := SpezieswerteLaden (LadenPrüfenExtern => True,
                                     DateiLadenExtern  => DateiLadenExtern);
      LadezeitenLogik.SpeichernLadenSchreiben (SpeichernLadenExtern => False);
      
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      LadezeitenLogik.SpeichernLadenMaximum;
      
   end Ladevorgang;
        
   
   
   -- Hier mal eine Möglichkeit finden die Speziesbelegung nicht einfach Prozedur/Funktionsübergreifend zu nutzen. äöü
   function AllgemeinesLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use Ada.Exceptions;
   begin
            
      SpielRecords.AllgemeinesRecord'Read (Stream (File => DateiLadenExtern),
                                           Allgemeines);
      
      SpielRecords.SpeziesbelegungArray'Read (Stream (File => DateiLadenExtern),
                                              Speziesbelegung);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeAllgemeines.GanzerEintrag (EintragExtern => Allgemeines);
            SchreibeSpeziesbelegung.GanzesArray (ArrayExtern => Speziesbelegung);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenLogik.AllgemeinesLaden: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end AllgemeinesLaden;
   
   
   
   function SpezieswerteLaden
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           Speziesbelegung (SpeziesSchleifenwert).Belegung = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         elsif
           False = StädteEinheitenLaden (LadenPrüfenExtern => LadenPrüfenExtern,
                                          SpeziesExtern     => SpeziesSchleifenwert,
                                          DateiLadenExtern  => DateiLadenExtern)
         then
            return False;
               
         elsif
           False = Spezieswerte (LadenPrüfenExtern => LadenPrüfenExtern,
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
      
      SpielRecords.GrenzenRecord'Read (Stream (File => DateiLadenExtern),
                                       Grenzen);
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeGrenzen.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                           EintragExtern => Grenzen);
            
         when False =>
            null;
      end case;
      
      
      
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


   
   function Spezieswerte
     (LadenPrüfenExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      DateiLadenExtern : in File_Type)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use Ada.Exceptions;
   begin
            
      DiplomatieSchleife:
      for SpeziesDiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop

         if
           Speziesbelegung (SpeziesDiplomatieSchleifenwert).Belegung = SpeziesDatentypen.Leer_Spieler_Enum
           or
             SpeziesExtern = SpeziesDiplomatieSchleifenwert
         then
            null;
            
         else
            SpielRecords.DiplomatieRecord'Read (Stream (File => DateiLadenExtern),
                                                Diplomatie);
            
            case
              LadenPrüfenExtern
            is
               when True =>
                  SchreibeDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                                    SpeziesZweiExtern => SpeziesDiplomatieSchleifenwert,
                                                    EintragExtern     => Diplomatie);
            
               when False =>
                  null;
            end case;
         end if;

      end loop DiplomatieSchleife;
      
      
      SpielRecords.WichtigesRecord'Read (Stream (File => DateiLadenExtern),
                                         Wichtiges);
      
      case
        Speziesbelegung (SpeziesExtern).Belegung
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            KartenRecords.ZeigerRecord'Read (Stream (File => DateiLadenExtern),
                                             Zeiger);
            
         when others =>
            null;
      end case;
            
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWichtiges.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                             EintragExtern => Wichtiges);
            
            if
              Speziesbelegung (SpeziesExtern).Belegung = SpeziesDatentypen.Mensch_Spieler_Enum
            then
               SchreibeZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                             EintragExtern => Zeiger);
               
            else
               null;
            end if;
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenLogik.Spezieswerte: Konnte nicht geladen werden: " & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Spezieswerte;

end LadenLogik;
