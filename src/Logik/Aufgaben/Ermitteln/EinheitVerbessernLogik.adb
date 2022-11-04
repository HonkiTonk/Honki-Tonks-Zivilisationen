pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenmodifizierungLogik;
with ForschungstestsLogik;

package body EinheitVerbessernLogik is

   function VerbesserungEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      IDNeueEinheit := LeseEinheitenDatenbank.VerbesserungZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => IDEinheit);
      
      if
        IDNeueEinheit = EinheitenDatentypen.EinheitenIDMitNullWert'First
      then
         return False;
           
      elsif
        False = LeseWeltkarte.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                          KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      then
         return False;
         
      elsif
        False = ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
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
                                                     RechnenSetzenExtern      => False);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 VorzeichenWechselExtern  => -1);
      
            SchreibeEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        IDExtern                 => IDNeueEinheit);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 VorzeichenWechselExtern  => 1);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;

end EinheitVerbessernLogik;
