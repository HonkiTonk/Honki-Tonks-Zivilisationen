case
   LeseKarten.BelegterGrund (RasseExtern       => RasseExtern,
                              KoordinatenExtern => KoordinatenExtern)
 is
    when False =>
       return StadtKonstanten.LeerNummer;

     when True =>
        null;
  end case;

  StadtSchleife:
  for StadtNummerSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Städtegrenze loop

      if
        LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert)) /= KoordinatenExtern
     then
        null;

    else
       return StadtNummerSchleifenwert;
    end if;

  end loop StadtSchleife;

   return StadtKonstanten.LeerNummer;



   RasseSchleife:
  for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

     case
      SpielVariablen.RassenImSpiel (RasseSchleifenwert)
    is
       when RassenDatentypen.Leer_Spieler_Enum =>
         null;

      when others =>
        StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                       KoordinatenExtern => KoordinatenExtern);

        if
          StadtNummer = StadtKonstanten.LeerNummer
      then
         null;

      else
         return (RasseSchleifenwert, StadtNummer);
     end if;
  end case;

 end loop RasseSchleife;

return StadtKonstanten.LeerRasseNummer;



  RasseSchleife:
  for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop

    if
      RasseExtern = RasseSchleifenwert
      or
        SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
   then
       null;

    else
       StadtNummer := KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseSchleifenwert,
                                                     KoordinatenExtern => KoordinatenExtern);

      case
        StadtNummer
     is
        when StadtKonstanten.LeerNummer =>
           null;

        when others =>
           return (RasseSchleifenwert, StadtNummer);
     end case;
   end if;

 end loop RasseSchleife;

  return StadtKonstanten.LeerRasseNummer;
