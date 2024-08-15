package KartenDatentypen is
   pragma Pure;

   type Senkrechte is range -1_000 .. 1_000;
   subtype SenkrechteNatural is Senkrechte range 0 .. Senkrechte'Last;
   subtype SenkrechtePositiv is SenkrechteNatural range 1 .. SenkrechteNatural'Last;
      
   -- Das hier kann vermutlich auch mal umgebaut/ersetzt/entfernt werden. äöü
   subtype SenkrechteSichtweiteNatural is SenkrechteNatural range SenkrechteNatural'First .. 10;
   -- Dafür auch mal einen subtype für die Einheitensichtweite einbauen? äöü
   subtype SenkrechteSichtweite is SenkrechteSichtweiteNatural range 1 .. SenkrechteSichtweiteNatural'Last;
   
   subtype SenkrechteUmgebungDrei is Senkrechte range -3 .. 3;
   subtype SenkrechteUmgebungZwei is SenkrechteUmgebungDrei range -2 .. 2;
   subtype SenkrechteUmgebungEins is SenkrechteUmgebungZwei range -1 .. 1;
   
   
   
   type Waagerechte is new Senkrechte;
   subtype WaagerechteNatural is Waagerechte range Waagerechte (SenkrechteNatural'First) .. Waagerechte (SenkrechteNatural'Last);
   subtype WaagerechtePositiv is WaagerechteNatural range WaagerechteNatural (SenkrechtePositiv'First) .. WaagerechteNatural (SenkrechtePositiv'Last);
      
   -- Das hier kann vermutlich auch mal umgebaut/ersetzt/entfernt werden. äöü
   subtype WaagerechteSichtweiteNatural is WaagerechteNatural range WaagerechteNatural (SenkrechteSichtweiteNatural'First) .. WaagerechtePositiv (SenkrechteSichtweiteNatural'Last);
   -- Dafür auch mal einen subtype für die Einheitensichtweite einbauen? äöü
   subtype WaagerechteSichtweite is WaagerechteSichtweiteNatural range WaagerechteSichtweiteNatural (SenkrechteSichtweite'First) .. WaagerechteSichtweiteNatural (SenkrechteSichtweite'Last);
   
   subtype WaagerechteUmgebungDrei is Waagerechte range Waagerechte (SenkrechteUmgebungDrei'First) .. WaagerechtePositiv (SenkrechteUmgebungDrei'Last);
   subtype WaagerechteUmgebungZwei is WaagerechteUmgebungDrei range WaagerechteUmgebungDrei (SenkrechteUmgebungZwei'First) .. WaagerechteUmgebungDrei (SenkrechteUmgebungZwei'Last);
   subtype WaagerechteUmgebungEins is WaagerechteUmgebungZwei range WaagerechteUmgebungZwei (SenkrechteUmgebungEins'First) .. WaagerechteUmgebungZwei (SenkrechteUmgebungEins'Last);
   
   
   
   -- Rückgabewert, Planeteninneres, Unterfläche, Oberfläche, Himmel, Weltraum
   type Ebene is new SenkrechteUmgebungDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. Ebene'Last;
   subtype EbenePlanet is EbeneVorhanden range EbeneVorhanden'First .. 0;
   subtype EbeneUnterflächeOberfläche is EbenePlanet range -1 .. 0;
   subtype EbeneOberfläche is EbeneVorhanden range 0 .. EbeneVorhanden'Last;
   subtype EbeneLuft is EbeneOberfläche range 1 .. EbeneVorhanden'Last;
   subtype EbenenbereichEins is EbeneVorhanden range EbeneVorhanden (SenkrechteUmgebungEins'First) .. EbeneVorhanden (SenkrechteUmgebungEins'Last);
   
   
   
   type KartengeneratorQuadranten is range 1 .. 25;
   subtype StandardQuadranten is KartengeneratorQuadranten range 1 .. 4;
   
   
   
   type Achsenverschiebung is new Float range 0.00 .. 1.00;

end KartenDatentypen;
