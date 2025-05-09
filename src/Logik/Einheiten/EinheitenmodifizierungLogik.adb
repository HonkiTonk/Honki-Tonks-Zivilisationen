with StadtKonstanten;
with ProduktionKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseWeltkarte;

with StadtproduktionLogik;
with KartenfeldereffekteLogik;

package body EinheitenmodifizierungLogik is

   procedure HeilungBewegungspunkteNeueRunde
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
      use type EinheitenDatentypen.Bewegungspunkte;
      use type KampfDatentypen.Lebenspunkte;
   begin
      
      AktuelleBeschäftigung := LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      -- Wird nur hier festgelegt, hatte das irgendwann einmal einen Grund? äöü
      -- Oder sollte das mal einen Grund haben und wurde nie/noch nicht eingebaut? äöü
      -- KIBeschäftigung := LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      Feldeffekt := KartenfeldereffekteLogik.FeldeffektVorhanden (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));

      if
        Feldeffekt = False
        and
          (AktuelleBeschäftigung = AufgabenDatentypen.Heilen_Enum
           or
             AktuelleBeschäftigung = AufgabenDatentypen.Verschanzen_Enum)
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               LebenspunkteExtern         => Heilungsrate,
                                               RechnenSetzenExtern        => True);
         
      elsif
        Feldeffekt = False
        and
          AktuelleBeschäftigung = AufgabenDatentypen.Leer_Aufgabe_Enum
          and
            LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                                             IDExtern    => EinheitID)
      then
         SchreibeEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               LebenspunkteExtern         => Heilungsrate / 2,
                                               RechnenSetzenExtern        => True);
         
      else
         null;
      end if;
      
      case
        AktuelleBeschäftigung
      is
         when EinheitenKonstanten.LeerBeschäftigung =>
            if
              Feldeffekt = False
            then
               SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        BewegungspunkteExtern      => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                      IDExtern      => EinheitID),
                                                        RechnenSetzenExtern        => False);
               
            else
               SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        BewegungspunkteExtern      => LeseEinheitenDatenbank.MaximaleBewegungspunkte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                      IDExtern      => EinheitID)
                                                        / 2,
                                                        RechnenSetzenExtern        => False);
            end if;

         when others =>
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                                     RechnenSetzenExtern        => False);
      end case;
      
   end HeilungBewegungspunkteNeueRunde;
   
      
   
   procedure PermanenteKostenÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      VorzeichenwechselExtern : in ProduktionDatentypen.Vorzeichenwechsel)
   is begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Heimatstadt
      is
         when StadtDatentypen.Städtebereich'First =>
            return;
            
         when others =>
            AktuelleID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      PermanenteKostenSchleife:
      for PermanenteKostenSchleifenwert in StadtRecords.PermanenteKostenArray'Range loop
         
         if
           0 > LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                        IDExtern           => AktuelleID,
                                                        WelcheKostenExtern => PermanenteKostenSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.PermanenteKostenPosten (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt),
                                                        WelcherPostenExtern      => PermanenteKostenSchleifenwert,
                                                        KostenExtern             => VorzeichenwechselExtern * LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                                                       IDExtern           => AktuelleID,
                                                                                                                                                       WelcheKostenExtern => PermanenteKostenSchleifenwert),
                                                        ÄndernSetzenExtern     => True);
         end if;
         
      end loop PermanenteKostenSchleife;
      
      StadtproduktionLogik.Stadtproduktion (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt));
      
   end PermanenteKostenÄndern;
   
   
   
   procedure HeimatstadtÄndern
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.Städtebereich;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitNummer := EinheitSpeziesNummerExtern.Nummer;
            
      NeueHeimatstadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      if
        NeueHeimatstadt.Nummer = StadtKonstanten.LeerNummer
        or
          EinheitSpeziesNummerExtern.Spezies /= NeueHeimatstadt.Spezies
      then
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenwechselExtern    => ProduktionKonstanten.VorzeichenNegativ);
      
         SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                              HeimatstadtExtern          => StadtKonstanten.LeerNummer);
         return;
         
      elsif
        NeueHeimatstadt.Nummer = LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer))
      then
         return;
         
      else
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenwechselExtern    => ProduktionKonstanten.VorzeichenNegativ);
      
         SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                              HeimatstadtExtern          => NeueHeimatstadt.Nummer);
      
         PermanenteKostenÄndern (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitNummer),
                                  VorzeichenwechselExtern    => ProduktionKonstanten.VorzeichenPositiv);
      end if;
      
   end HeimatstadtÄndern;

end EinheitenmodifizierungLogik;
