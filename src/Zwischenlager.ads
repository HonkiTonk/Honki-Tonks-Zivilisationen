with LeseEinheitenGebaut;
with LeseCursor;

with TasteneingabeLogik;
with EinheitenmodifizierungLogik;
with StadtBauenLogik;
with AufgabenLogik;
with EinheitenbewegungLogik;
with KartenkoordinatenberechnungssystemLogik;
with MausauswahlLogik;
with PZBEingesetztLogik;
with EinheitentransporterLogik;
with NachGrafiktask;
with EinheitenbewegungsbereichLogik;

package body EinheitenkontrollsystemLogik is

   procedure Einheitenkontrolle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin

      Bewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      KontrollSchleife:
      loop

         case
           EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                           BefehlExtern             => TasteneingabeLogik.Einheitentaste)
         is
            when True =>
               if
                 Bewegungspunkte = LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
               then
                  null;

               else
                  EinheitenbewegungsbereichLogik.BewegungsbereichBerechnen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               end if;

            when False =>
               return;
         end case;

      end loop KontrollSchleife;

   end Einheitenkontrolle;



   function EinheitBefehle
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      BefehlExtern : in BefehleDatentypen.Einheitenbelegung_Enum)
      return Boolean
   is begin

      case
        BefehlExtern
      is
         when BefehleDatentypen.Auswählen_Enum =>
            return BefehleMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            NachGrafiktask.EinheitBewegt := True;
            return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           ÄnderungExtern           => Richtung (BefehlExtern));

         when BefehleDatentypen.Heimatstadt_Ändern_Enum =>
            EinheitenmodifizierungLogik.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return True;

         when BefehleDatentypen.Entladen_Enum =>
            EinheitentransporterLogik.TransporterEntladen (TransporterExtern => EinheitRasseNummerExtern);
            return True;

         when BefehleDatentypen.Siedler_Verbesserung_Enum'Range | BefehleDatentypen.Einheiten_Allgemeine_Befehle_Enum'Range =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichen Aufgabenanfang keine Bewegung mehr möglich ist und umgekehrt.
            return not AufgabenLogik.Aufgabe (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              BefehlExtern             => BefehlExtern,
                                              KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));

         when BefehleDatentypen.Bauen_Enum =>
            -- Das Umgekehrte zurückgeben da bei erfolgreichem Städtebau keine Bewegung mehr möglich ist und umgekehrt.
            return not StadtBauenLogik.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

            -- Da das der Standardrückgabewert ist muss hier True zurückgegeben werden, da sonst die Schleife direkt nach der Auswahl wieder verlassen wird!
         when BefehleDatentypen.Leer_Einheitenbelegung_Enum =>
            return True;

         when others =>
            return False;
      end case;

   end EinheitBefehle;



   function BefehleMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin

      Mausbefehl := MausauswahlLogik.Einheitenbefehle;

      case
        Mausbefehl
      is
         when BefehleDatentypen.Einheiten_Bewegung_Enum'Range =>
            return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           ÄnderungExtern          => Richtung (Mausbefehl));

         when BefehleDatentypen.Einheiten_Aufgaben_Enum'Range =>
            if
              PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return False;

            else
               return EinheitBefehle (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      BefehlExtern             => Mausbefehl);
            end if;

         when BefehleDatentypen.Auswählen_Enum =>
            return AllgemeineEinheitenbewegungMaus (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

         when others =>
            return False;
      end case;

   end BefehleMaus;



   function AllgemeineEinheitenbewegungMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin

      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);

               -- In diesem Fall wird die Prüfung auf Leer nicht benötigt, da im aktuellen System die Cursorkoordinaten niemals ungültig sein können.
               if
                 KartenWert = LeseCursor.KoordinatenAktuell (RasseExtern => EinheitRasseNummerExtern.Rasse)
               then
                  return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 ÄnderungExtern           => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));

               else
                  null;
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

      return True;

   end AllgemeineEinheitenbewegungMaus;



   function EinheitenbewegungMaus
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin

      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop

               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);

               -- In diesem Fall wird die Prüfung auf Leer nicht benötigt, da im aktuellen System die Cursorkoordinaten niemals ungültig sein können.
               if
                 KartenWert = LeseCursor.KoordinatenAktuell (RasseExtern => EinheitRasseNummerExtern.Rasse)
               then
                  -- Und hier müsste ich dann ein Webgfindungssystem einbauen wie es die KI hat. äöü
                  -- Kann ich das KI System dazu anpassen? Wahrscheinlich nicht. äöü
                  -- Aber ich kann das Bewegungsarrray der Einheit dazu verwenden, da es bei menschlichen Spielern ja leer sein sollte und dann entsprechend die Bewegung berechnen. äöü
                  return EinheitenbewegungLogik.PositionÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 ÄnderungExtern           => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));

               else
                  null;
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

      return True;

   end EinheitenbewegungMaus;

end EinheitenkontrollsystemLogik;
