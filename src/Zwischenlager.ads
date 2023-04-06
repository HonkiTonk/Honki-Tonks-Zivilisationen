-- Kann ich das hier noch an anderen Stellen verwenden? äöü
function StadtfeldSuchen
  (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
is begin

   EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);

   -- Hier noch eine Überprüfung einbauen ob die Ebenenänderung überhaupt möglich ist? äöü
   -- Dann müsste ich nicht immer alles durchgehen. äöü
   EAchseSchleife:
   for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop

      QuadrantenDurchgegangen := (others => False);

      QuadrantenSchleife:
      for QuadrantenSchleifenwert in QuadrantenDurchgegangenArray'Range loop
         QuadrantenauswahlSchleife:
         loop

            WelcherQuadrant := KartenDatentypen.StandardQuadranten (ZufallegeneratorenAllgemein.VorgegebenerZahlenbereich (AnfangExtern => Positive (QuadrantenDurchgegangenArray'First),
                                                                                                                           EndeExtern   => Positive (QuadrantenDurchgegangenArray'Last)));

            case
              QuadrantenDurchgegangen (WelcherQuadrant)
            is
               when False =>
                  QuadrantenDurchgegangen (WelcherQuadrant) := True;
                  exit QuadrantenauswahlSchleife;

               when True =>
                  null;
            end case;

         end loop QuadrantenauswahlSchleife;

         case
           WelcherQuadrant
         is
            when 1 =>
               -- Y geht hier von 0 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
               YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               Multiplikator := (-1, 1);

            when 2 =>
               YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               XQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               Multiplikator := (1, 1);

            when 3 =>
               YQuadrantenbereich := (0, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               -- X geht hier von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
               XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               Multiplikator := (1, -1);

            when 4 =>
               -- Hier geht beides von -1 bis -Reichweite, deswegen den Multiplikator auf -1 setzen.
               YQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               XQuadrantenbereich := (1, KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad));
               Multiplikator := (-1, -1);
         end case;

         YAchseSchleife:
         for YAchseSchleifenwert in YQuadrantenbereich.Anfang .. YQuadrantenbereich.Ende loop
            XAchseSchleife:
            for XAchseSchleifenwert in XQuadrantenbereich.Anfang .. XQuadrantenbereich.Ende loop

               MöglichesStadtfeld := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                                  ÄnderungExtern    => (EAchseSchleifenwert,
                                                                                                                                         Multiplikator.YAchse * YAchseSchleifenwert,
                                                                                                                                         Multiplikator.XAchse * XAchseSchleifenwert),
                                                                                                                  LogikGrafikExtern => True);

               if
                 MöglichesStadtfeld.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;

               elsif
                 False = KartenfeldUmgebungPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => MöglichesStadtfeld)
               then
                  null;

               elsif
                 False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                                     SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                                     ZielKoordinatenExtern => MöglichesStadtfeld)
               then
                  return MöglichesStadtfeld;

               else
                  null;
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop QuadrantenSchleife;
   end loop EAchseSchleife;

   return KartenRecordKonstanten.LeerKoordinate;

end StadtfeldSuchen;



function KartenfeldUmgebungPrüfen
  (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
   KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
is
   use type KartengrundDatentypen.Basisgrund_Enum;
begin

   case
     KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                           KoordinatenExtern          => KoordinatenExtern)
   is
      when False =>
         return False;

      when True =>
         null;
   end case;

   -- Diese Prüfung hier mal Speziesspezifisch erweitern. äöü
   if
     LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
   then
      return False;

   elsif
     False = KIKartenfeldbewertungModifizierenLogik.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                         SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
   then
      return False;

   else
      return True;
   end if;

end KartenfeldUmgebungPrüfen;
