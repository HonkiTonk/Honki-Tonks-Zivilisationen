pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseKarten;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenModifizieren;
with ForschungAllgemein;

package body AufgabeEinheitVerbessern is

   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      IDNeueEinheit := LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => IDEinheit);
      
      if
        IDNeueEinheit = EinheitenDatentypen.EinheitenIDMitNullWert'First
      then
         return False;
           
      elsif
        False = LeseKarten.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                          KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;
         
      elsif
        False = ForschungAllgemein.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                         TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                    IDExtern    => IDNeueEinheit))
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
      
            EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           VorzeichenWechselExtern  => -1);
      
            SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        IDExtern                 => IDNeueEinheit);
      
            EinheitenModifizieren.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           VorzeichenWechselExtern  => 1);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;

end AufgabeEinheitVerbessern;
