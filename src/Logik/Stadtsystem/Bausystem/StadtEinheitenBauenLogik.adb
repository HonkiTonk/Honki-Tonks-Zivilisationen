with EinheitenKonstanten;
with StadtDatentypen;

with KIDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with LeseCursor;
with SchreibeCursor;

with EinheitSuchenLogik;
with StadtumgebungErreichbarLogik;
with MeldungenSetzenLogik;
with EinheitenErzeugenEntfernenLogik;

package body StadtEinheitenBauenLogik is

   procedure EinheitFertiggestellt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      EinheitNummer := 0;
            
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => StadtRasseNummerExtern.Rasse) loop
            
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
          LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse) = RassenDatentypen.Mensch_Spieler_Enum
      then
         SchreibeCursor.KoordinatenAktuell (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                            KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern));
         SchreibeCursor.KoordinatenAlt (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                        KoordinatenExtern => LeseCursor.KoordinatenAktuell (RasseExtern => StadtRasseNummerExtern.Rasse));
         
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
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        EinheitenKonstanten.LeerNummer = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                                               LogikGrafikExtern => True).Nummer
      then
         KartenWert := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         KartenWert := StadtumgebungErreichbarLogik.UmgebungErreichbar (AktuelleKoordinatenExtern => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        RasseExtern               => StadtRasseNummerExtern.Rasse,
                                                                        IDExtern                  => EinheitenDatentypen.EinheitenID (LeseStadtGebaut.Bauprojekt (StadtRasseNummerExtern => StadtRasseNummerExtern).Einheit),
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
        LeseRassenbelegung.Belegung (RasseExtern => StadtRasseNummerExtern.Rasse)
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
