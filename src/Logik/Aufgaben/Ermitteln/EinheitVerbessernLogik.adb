with KartenDatentypen;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with EinheitenmodifizierungLogik;
with ForschungstestsLogik;

package body EinheitVerbessernLogik is

   function VerbesserungEinheit
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type KartenDatentypen.Kartenfeld;
   begin
      
      NeueEinheitenID := EinheitVerbesserbar (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        NeueEinheitenID = EinheitenKonstanten.LeerID
      then
         return False;
           
      elsif
        False = LeseWeltkarte.BelegterGrund (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                             KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      then
         return False;
         
      else
         null;
      end if;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern      => False);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                 VorzeichenWechselExtern  => -1);
      
            SchreibeEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                        IDExtern                 => NeueEinheitenID);
      
            EinheitenmodifizierungLogik.PermanenteKostenÄndern (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                 VorzeichenWechselExtern  => 1);
                                    
         when False =>
            null;
      end case;
      
      return True;
      
   end VerbesserungEinheit;
   
   
   
   function EinheitVerbesserbar
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.EinheitenIDMitNullWert
   is begin
   
      NeueEinheitenID := LeseEinheitenDatenbank.VerbesserungZu (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      case
        NeueEinheitenID
      is
         when EinheitenKonstanten.LeerID =>
            return EinheitenKonstanten.LeerID;
            
         when others =>
            null;
      end case;
      
      case
        ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies,
                                                   TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                              IDExtern    => NeueEinheitenID))
      is
         when True =>
            return NeueEinheitenID;
            
         when False =>
            return EinheitenKonstanten.LeerID;
      end case;
      
   end EinheitVerbesserbar;

end EinheitVerbessernLogik;
