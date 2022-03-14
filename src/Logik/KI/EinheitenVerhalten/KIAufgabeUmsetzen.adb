pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenVerbesserungKonstanten;
with TastenbelegungKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with Aufgaben;

package body KIAufgabeUmsetzen is
   
   function WelcheVerbesserungAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        LeseKarten.VerbesserungGebiet (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungGebiet =>
            if
              VerbesserungGebiet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return True;
               
            else
               null;
            end if;
      
         when others =>
            null;
      end case;
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg =>
            return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 BefehlExtern             => TastenbelegungKonstanten.StraßeBauenKonstante);
            
         when others =>
            null;
      end case;
      
      return False;
      
   end WelcheVerbesserungAnlegen;
   
   
   
   function VerbesserungGebiet
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      Grund := LeseKarten.Grund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
         
      if
        (Grund = KartenDatentypen.Hügel
         or
           Grund = KartenDatentypen.Gebirge
         or
           Grund = KartenDatentypen.Kohle
         or
           Grund = KartenDatentypen.Eisen
         or
           Grund = KartenDatentypen.Gold
         or
           LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungKonstanten.MineBauenKonstante)
        = True
      then
         Befehl := TastenbelegungKonstanten.MineBauenKonstante;
         
      elsif
        Grund = KartenDatentypen.Eis
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungKonstanten.FestungBauenKonstante)
        = True
      then
         Befehl := TastenbelegungKonstanten.FestungBauenKonstante;
         
      elsif
        Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     BefehlExtern             => TastenbelegungKonstanten.FarmBauenKonstante)
        = True
      then
         Befehl := TastenbelegungKonstanten.FarmBauenKonstante;
            
      else
         return False;
      end if;
      
      return Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           BefehlExtern             => Befehl);
      
   end VerbesserungGebiet;
      
      

   function EinheitVerbessern
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      NullWert := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                BefehlExtern             => TastenbelegungKonstanten.EinheitVerbessernKonstante);
      
      return False;
      
   end EinheitVerbessern;

end KIAufgabeUmsetzen;
