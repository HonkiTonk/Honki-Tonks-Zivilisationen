with DiplomatieDatentypen;
with KartenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseDiplomatie;

with KIDatentypen;

with KIEinheitSuchenLogik;
with KIStadtSuchenLogik;

package body KIEinheitFestlegenAngreifenLogik is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      WenAngreifen := ZielErmitteln (RasseExtern => EinheitRasseNummerExtern.Rasse);
      
      case
        WenAngreifen
      is
         when EinheitenKonstanten.LeerRasse =>
            return False;
            
         when others =>
            KoordinatenFeind := KIEinheitSuchenLogik.FeindlicheEinheitInUmgebungSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                        FeindExtern              => WenAngreifen);
      end case;
            
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            null;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Angreifen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
            return True;
      end case;
      
      KoordinatenFeind := KIStadtSuchenLogik.NähesteFeindlicheStadtSuchen (RasseExtern             => WenAngreifen,
                                                                            AnfangKoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        KoordinatenFeind.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return False;
            
         when others =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Angreifen_Enum);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KoordinatenFeind);
            return True;
      end case;
   end Angreifen;
   
   
   
   function ZielErmitteln
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Rassen_Enum
   is
      use type DiplomatieDatentypen.Status_Untereinander_Enum;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      Ziel := EinheitenKonstanten.LeerRasse;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           LeseRassenbelegung.Belegung (RasseExtern => RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseSchleifenwert = RasseExtern
         then
            null;
            
         elsif
           DiplomatieDatentypen.Krieg_Enum = LeseDiplomatie.AktuellerZustand (RasseEinsExtern => RasseExtern,
                                                                              RasseZweiExtern => RasseSchleifenwert)
         then
            -- Es sollte auch noch Prüfungen auf die Stärke der feindlichen Rassen erfolgen. äöü
            Ziel := RasseSchleifenwert;
            exit RassenSchleife;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return Ziel;
      
   end ZielErmitteln;

end KIEinheitFestlegenAngreifenLogik;
