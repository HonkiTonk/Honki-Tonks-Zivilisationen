pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with DiplomatieDatentypen; use DiplomatieDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with DiplomatischerZustand;

with KIDatentypen;

with KIEinheitSuchen;
with KIStadtSuchen;

package body KIEinheitFestlegenAngreifen is

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
            KoordinatenFeind := KIEinheitSuchen.FeindlicheEinheitInUmgebungSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
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
      
      KoordinatenFeind := KIStadtSuchen.NähesteFeindlicheStadtSuchen (RasseExtern             => WenAngreifen,
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
   is begin
      
      Ziel := EinheitenKonstanten.LeerRasse;
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseSchleifenwert = RasseExtern
         then
            null;
            
         elsif
           DiplomatieDatentypen.Krieg_Enum = DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => RasseExtern,
                                                                                                FremdeRasseExtern => RasseSchleifenwert)
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

end KIEinheitFestlegenAngreifen;
