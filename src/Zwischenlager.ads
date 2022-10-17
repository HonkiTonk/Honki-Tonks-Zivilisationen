procedure CursorbewegungBerechnen
  (RichtungExtern : in TastenbelegungDatentypen.Tastenbelegung_Bewegung_Erweitert_Enum;
   RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
is begin

   -- Das Scrollen duch die Ebenen auch noch von den Ebenenübergangeinstellungen abhängig machen? äöü
   if
     SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = KartenKonstanten.WeltraumKonstante
     and
       RichtungExtern = TastenbelegungDatentypen.Ebene_Hoch_Enum
   then
      KartenWert := (KartenKonstanten.PlaneteninneresKonstante, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse);

   elsif
     SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.EAchse = KartenKonstanten.PlaneteninneresKonstante
     and
       RichtungExtern = TastenbelegungDatentypen.Ebene_Runter_Enum
   then
      KartenWert := (KartenKonstanten.WeltraumKonstante, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse, SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse);

   else
      KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
                                                                                                ÄnderungExtern    => Richtung (RichtungExtern),
                                                                                                LogikGrafikExtern => True);
   end if;

   case
     KartenWert.XAchse
   is
      when KartenKonstanten.LeerXAchse =>
         null;

      when others =>
         NachGrafiktask.GeheZu := KartenWert;
   end case;

end CursorbewegungBerechnen;
