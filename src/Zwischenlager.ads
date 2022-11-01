
case
  Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => FeldKoordinatenExtern,
                                   KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
is
   when True =>
      EinheitWegbewegen (BewegendeEinheitExtern => EinheitRasseNummerExtern,
                         StehendeEinheitExtern  => BlockierendeEinheit);

   when False =>
      null;
end case;





procedure EinheitWegbewegen
  (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
   StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
is begin

   case
     LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => StehendeEinheitExtern)
   is
      when KIDatentypen.Tut_Nichts_Enum | KIDatentypen.Leer_Aufgabe_Enum =>
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => StehendeEinheitExtern,
                                                 AufgabeExtern            => KIDatentypen.Platz_Machen_Enum);

         SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => BewegendeEinheitExtern,
                                                  BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                  RechnenSetzenExtern      => False);

      when others =>
         null;
   end case;

end EinheitWegbewegen;

procedure EinheitWegbewegen
  (BewegendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
   StehendeEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord)
  with
    Pre => (
              BewegendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (BewegendeEinheitExtern.Rasse).Einheitengrenze
            and
              SpielVariablen.Rassenbelegung (BewegendeEinheitExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
            and
              StehendeEinheitExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StehendeEinheitExtern.Rasse).Einheitengrenze
            and
              SpielVariablen.Rassenbelegung (StehendeEinheitExtern.Rasse).Belegung = RassenDatentypen.KI_Spieler_Enum
           );
