pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with EinheitSuchenLogik;
with StadtumgebungErreichbarLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;

package body StadtEinheitenBauenLogik is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
            
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               EinheitNummer := EinheitNummerSchleifenwert;
               exit EinheitenSchleife;
            
            when others =>
               null;
         end case;
            
      end loop EinheitenSchleife;
      
      if
        EinheitNummer = EinheitenKonstanten.LeerNummer
        and
          SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung = RassenDatentypen.Mensch_Spieler_Enum
      then
         SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
         SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAlt := SpielVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).KoordinatenAktuell;
         
      elsif
        EinheitNummer = EinheitenKonstanten.LeerNummer
      then
         null;
         
      else
         PlatzErmitteln (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end if;
      
   end EinheitFertiggestellt;
   
   
   
   procedure PlatzErmitteln
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      if
        EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                               LogikGrafikExtern => True).Nummer
      then
         KartenWert := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         KartenWert := StadtumgebungErreichbarLogik.UmgebungErreichbar (AktuelleKoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        RasseExtern               => StadtRasseNummerExtern.Rasse,
                                                                        IDExtern                  => EinheitenDatentypen.EinheitenID (SpielVariablen.StadtGebaut
                                                                          (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer).Bauprojekt.Einheit),
                                                                        NotwendigeFelderExtern    => 1);
      end if;
      
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => StadtDatentypen.Einheit_Unplatzierbar_Enum);
            
         when others =>
            EinheitPlatzieren (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KartenWert);
      end case;
      
   end PlatzErmitteln;
   
   
   
   procedure EinheitPlatzieren
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern      => KoordinatenExtern,
                                                       EinheitNummerExtern    => EinheitNummer,
                                                       IDExtern               =>  EinheitenDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Einheit),
                                                       StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeStadtGebaut.Ressourcen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      RessourcenExtern       => StadtKonstanten.LeerRessourcen,
                                      ÄndernSetzenExtern     => False);
      SchreibeStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                      BauprojektExtern       => StadtKonstanten.LeerBauprojekt);
            
      case
        SpielVariablen.Rassenbelegung (StadtRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            MeldungenSetzenLogik.StadtmeldungSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                             EreignisExtern         => StadtDatentypen.Produktion_Abgeschlossen_Enum);
         
         when others =>
            SchreibeStadtGebaut.KIBeschäftigung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  BeschäftigungExtern    => KIDatentypen.Keine_Aufgabe_Enum);
      end case;
      
   end EinheitPlatzieren;

end StadtEinheitenBauenLogik;
