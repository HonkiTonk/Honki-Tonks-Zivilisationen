with Ada.Exceptions;

with DateizugriffssystemHTSEB;
with LadezeitenDatentypen;
with TextKonstantenHTSEB;
with UmwandlungssystemHTSEB;
with MeldungssystemHTSEB;

with GrafikDatentypen;
with TextnummernKonstanten;
with SpielstandVariablen;

with SchreibeEinheitenGebaut;
with SchreibeGrafiktask;

with LadezeitenLogik;
with SpielstandlisteLogik;
with MeldungFestlegenLogik;
with StandardSpielwerteSetzenLogik;
with LadenKarteLogik;
with UmwandlungenVerzeichnisse;
with LadenAllgemeinesLogik;
with LadenSpeziesLogik;

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
            SchreibeGrafiktask.Dateiname (DateinameExtern => Spielstandname);
            SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Prüfen_Enum);
            
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
               LadezeitenLogik.SpeichernLadenNullsetzen;
               SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Laden_Enum);
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
        LadenAllgemeinesLogik.Aufteilung (LadenPrüfenExtern => False,
                                          DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            LadezeitenLogik.SpeichernLadenMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Allgemeines_Enum);
      end case;
      
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
        LadenSpeziesLogik.SpezieswerteLaden (LadenPrüfenExtern => False,
                                             DateiLadenExtern  => DateiLadenExtern)
      is
         when False =>
            return False;
            
         when True =>
            return True;
      end case;
      
   end Prüfen;
   
   
   
   procedure Ladevorgang
     (DateiLadenExtern : in File_Type)
   is begin
               
      Leerwert := LadenAllgemeinesLogik.Aufteilung (LadenPrüfenExtern => True,
                                                    DateiLadenExtern  => DateiLadenExtern);
               
      Leerwert := LadenKarteLogik.KarteLaden (LadenPrüfenExtern => True,
                                              DateiLadenExtern  => DateiLadenExtern);
      
      Leerwert := LadenSpeziesLogik.SpezieswerteLaden (LadenPrüfenExtern => True,
                                                       DateiLadenExtern  => DateiLadenExtern);
      
      SchreibeEinheitenGebaut.Standardbewegungsplan;
      
   end Ladevorgang;

end LadenLogik;
