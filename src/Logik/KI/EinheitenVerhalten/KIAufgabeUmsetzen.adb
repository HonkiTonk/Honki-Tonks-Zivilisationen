pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenVerbesserungKonstanten;
with TastenbelegungKonstanten;
with KartenGrundKonstanten;

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
        (Grund = KartenGrundKonstanten.HügelKonstante
         or
           Grund = KartenGrundKonstanten.GebirgeKonstante
         or
           Grund = KartenGrundKonstanten.KohleKonstante
         or
           Grund = KartenGrundKonstanten.EisenKonstante
         or
           Grund = KartenGrundKonstanten.GoldKonstante
         or
           LeseKarten.Hügel (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True)
        and
          Aufgaben.VerbesserungTesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       BefehlExtern             => TastenbelegungKonstanten.MineBauenKonstante)
        = True
      then
         Befehl := TastenbelegungKonstanten.MineBauenKonstante;
         
      elsif
        Grund = KartenGrundKonstanten.EisKonstante
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
