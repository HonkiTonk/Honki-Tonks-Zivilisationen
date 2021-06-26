pragma SPARK_Mode (On);

with EinheitenDatenbank;

with LesenGlobaleVariablen;

package body ZugriffEinheitenDatenbank is
   
   -- Ohne ID
   function GrafikOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).EinheitenGrafik;
      
   end GrafikOhneID;
   
   
   
   function TypOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.EinheitenTyp
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).EinheitTyp;
      
   end TypOhneID;
   
   
   
   function PreisGeldOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).PreisGeld;
      
   end PreisGeldOhneID;
   
   
   
   function PreisRessourcenOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).PreisRessourcen;
      
   end PreisRessourcenOhneID;
   
   
   
   function AnforderungenOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Anforderungen;
      
   end AnforderungenOhneID;
   
   
   
   function MaximaleLebenspunkteOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Positive
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkteOhneID;
   
   
   
   function MaximaleBewegungspunkteOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Float
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).MaximaleBewegungspunkte;
      
   end MaximaleBewegungspunkteOhneID;
   
   
   
   function BeförderungsgrenzeOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Positive
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Beförderungsgrenze;
      
   end BeförderungsgrenzeOhneID;
   
   
   
   function MaximalerRangOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).MaximalerRang;
      
   end MaximalerRangOhneID;
   
   
   
   function ReichweiteOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Reichweite;
      
   end ReichweiteOhneID;
   
   
   
   function AngriffOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Angriff;
      
   end AngriffOhneID;
   
   
   
   function VerteidigungOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Verteidigung;
      
   end VerteidigungOhneID;
   
   
   
   function KannTransportierenOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).KannTransportieren;
      
   end KannTransportierenOhneID;
   
   
   
   function KannTransportiertWerdenOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).KannTransportiertWerden;
      
   end KannTransportiertWerdenOhneID;
   
   
   
   function TransportkapazitätOhneID
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (EinheitRasseNummerExtern.Rasse,
                                                LesenGlobaleVariablen.EinheitenID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                                               ).Transportkapazität;
      
   end TransportkapazitätOhneID;
   -- Ohne ID
   
   

   -- Mit ID
   function GrafikMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Wide_Wide_Character
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitenGrafik;
      
   end GrafikMitID;
   
   
   
   function TypMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.EinheitenTyp
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).EinheitTyp;
      
   end TypMitID;
   
   
   
   function PreisGeldMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisGeld;
      
   end PreisGeldMitID;
   
   
   
   function PreisRessourcenMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).PreisRessourcen;
      
   end PreisRessourcenMitID;
   
   
   
   function AnforderungenMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.ForschungIDMitNullWert
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Anforderungen;
      
   end AnforderungenMitID;
   
   
   
   function MaximaleLebenspunkteMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Positive
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleLebenspunkte;
      
   end MaximaleLebenspunkteMitID;
   
   
   
   function MaximaleBewegungspunkteMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Float
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximaleBewegungspunkte;
      
   end MaximaleBewegungspunkteMitID;
   
   
   
   function BeförderungsgrenzeMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Positive
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Beförderungsgrenze;
      
   end BeförderungsgrenzeMitID;
   
   
   
   function MaximalerRangMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).MaximalerRang;
      
   end MaximalerRangMitID;
   
   
   
   function ReichweiteMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Reichweite;
      
   end ReichweiteMitID;
   
   
   
   function AngriffMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Angriff;
      
   end AngriffMitID;
   
   
   
   function VerteidigungMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return GlobaleDatentypen.WerteNahrungMaterialGeldWissenVerteidigungAngriff
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Verteidigung;
      
   end VerteidigungMitID;
   
   
   
   function KannTransportierenMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportieren;
      
   end KannTransportierenMitID;
   
   
   
   function KannTransportiertWerdenMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).KannTransportiertWerden;
      
   end KannTransportiertWerdenMitID;
   
   
   
   function TransportkapazitätMitID
     (RasseExtern : GlobaleDatentypen.Rassen;
      IDExtern : GlobaleDatentypen.EinheitenID)
      return Natural
   is begin
      
      return EinheitenDatenbank.EinheitenListe (RasseExtern, IDExtern).Transportkapazität;
      
   end TransportkapazitätMitID;
   -- Mit ID

end ZugriffEinheitenDatenbank;
