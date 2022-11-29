with KartenDatentypen;

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
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type KartenDatentypen.Kartenfeld;
   begin
      
      NeueEinheitenID := EinheitVerbesserbar (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        NeueEinheitenID = EinheitenKonstanten.LeerID
      then
         return False;
           
      elsif
        False = LeseWeltkarte.BelegterGrund (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                             KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
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
                                        IDExtern                 => NeueEinheitenID);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 VorzeichenWechselExtern  => 1);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   
   
   
   function EinheitVerbesserbar
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
   
      NeueEinheitenID := LeseEinheitenDatenbank.VerbesserungZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NeueEinheitenID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerID;
            
         when others =>
            null;
      end case;
      
      case
        ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                   TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                              IDExtern    => NeueEinheitenID))
      is
         when True =>
            return NeueEinheitenID;
            
         when False =>
            return EinheitenKonstanten.LeerID;
      end case;
      
   end EinheitVerbesserbar;

end EinheitVerbessernLogik;
