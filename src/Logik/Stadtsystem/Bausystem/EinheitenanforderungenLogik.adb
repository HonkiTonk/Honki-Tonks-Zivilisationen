with EinheitenKonstanten;
with StadtDatentypen;
with Projekteinstellungen;

with LeseStadtGebaut;
with LeseEinheitenDatenbank;

with ForschungstestsLogik;
with PassierbarkeitspruefungLogik;

package body EinheitenanforderungenLogik is

   function AnforderungenErfüllt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
   is
      use type EinheitenDatentypen.EinheitenID;
      use type EinheitenDatentypen.Einheitart_Enum;
   begin
      
      if
        IDExtern = EinheitenKonstanten.LeerID
      then
         return False;
         
      elsif
        EinheitenDatentypen.Cheat_Enum = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                              IDExtern      => IDExtern)
      then
         return Projekteinstellungen.Einstellungen.VolleInformation;
         
      elsif
        False = PassierbarkeitspruefungLogik.RichtigeUmgebungVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                        EinheitenIDExtern        => IDExtern)
      then
         return False;
         
      elsif
        False = ForschungstestsLogik.TechnologieVorhanden (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                           TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                      IDExtern      => IDExtern))
      then
         return False;
         
      else
         null;
      end if;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         if
           False = LeseEinheitenDatenbank.GebäudeBenötigt (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                             IDExtern      => IDExtern,
                                                             GebäudeExtern => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           True = LeseStadtGebaut.GebäudeVorhanden (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                     WelchesGebäudeExtern    => GebäudeSchleifenwert)
         then
            null;
            
         else
            return False;
         end if;
         
      end loop GebäudeSchleife;
      
      return True;
      
   end AnforderungenErfüllt;

end EinheitenanforderungenLogik;
